Looks like the kernel devs were about to fix palm detection on Precision Touchpads, but reached an impasse and never actually applied the patch: https://patchwork.kernel.org/patch/9894803/

Todo: apply this and 🙄 compile custom kernel because they can't come to an agreement...
```
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 440b999304a5..c28defe50a10 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -114,6 +114,8 @@  struct mt_device {
 	struct timer_list release_timer;	/* to release sticky fingers */
 	struct mt_fields *fields;	/* temporary placeholder for storing the
 					   multitouch fields */
+	unsigned long *pending_palm_slots; /* slots where we reported palm
+						and need to release */
 	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_*) */
 	int cc_index;	/* contact count field index in the report */
 	int cc_value_index;	/* contact count value index in the field */
@@ -543,8 +545,12 @@  static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONFIDENCE:
 			if ((cls->name == MT_CLS_WIN_8 ||
 				cls->name == MT_CLS_WIN_8_DUAL) &&
-				field->application == HID_DG_TOUCHPAD)
+			    field->application == HID_DG_TOUCHPAD) {
 				cls->quirks |= MT_QUIRK_CONFIDENCE;
+				input_set_abs_params(hi->input,
+					ABS_MT_TOOL_TYPE,
+					MT_TOOL_FINGER, MT_TOOL_PALM, 0, 0);
+			}
 			mt_store_field(usage, td, hi);
 			return 1;
 		case HID_DG_TIPSWITCH:
@@ -657,6 +663,7 @@  static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 
 	if (td->curvalid || (td->mtclass.quirks & MT_QUIRK_ALWAYS_VALID)) {
 		int active;
+		int tool;
 		int slotnum = mt_compute_slot(td, input);
 		struct mt_slot *s = &td->curdata;
 		struct input_mt *mt = input->mt;
@@ -671,24 +678,56 @@  static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 				return;
 		}
 
+		active = s->touch_state || s->inrange_state;
+
 		if (!(td->mtclass.quirks & MT_QUIRK_CONFIDENCE))
 			s->confidence_state = 1;
-		active = (s->touch_state || s->inrange_state) &&
-							s->confidence_state;
+
+		if (likely(s->confidence_state)) {
+			tool = MT_TOOL_FINGER;
+		} else {
+			tool = MT_TOOL_PALM;
+			if (!active &&
+			    input_mt_is_active(&mt->slots[slotnum])) {
+				/*
+				 * The non-confidence was reported for
+				 * previously valid contact that is also no
+				 * longer valid. We can't simply report
+				 * lift-off as userspace will not be aware
+				 * of non-confidence, so we need to split
+				 * it into 2 events: active MT_TOOL_PALM
+				 * and a separate liftoff.
+				 */
+				active = true;
+				set_bit(slotnum, td->pending_palm_slots);
+			}
+		}
 
 		input_mt_slot(input, slotnum);
-		input_mt_report_slot_state(input, MT_TOOL_FINGER, active);
+		input_mt_report_slot_state(input, tool, active);
 		if (active) {
 			/* this finger is in proximity of the sensor */
 			int wide = (s->w > s->h);
 			int major = max(s->w, s->h);
 			int minor = min(s->w, s->h);
 
-			/*
-			 * divided by two to match visual scale of touch
-			 * for devices with this quirk
-			 */
-			if (td->mtclass.quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+			if (unlikely(!s->confidence_state)) {
+				/*
+				 * When reporting palm, set contact to maximum
+				 * size to help userspace that does not
+				 * recognize MT_TOOL_PALM to reject contacts
+				 * that are too large.
+				 */
+				major = input_abs_get_max(input,
+							  ABS_MT_TOUCH_MAJOR);
+				minor = input_abs_get_max(input,
+							  ABS_MT_TOUCH_MINOR);
+			} else if (td->mtclass.quirks &
+					MT_QUIRK_TOUCH_SIZE_SCALING) {
+				/*
+				 * divided by two to match visual scale of touch
+				 * for devices with this quirk
+				 */
 				major = major >> 1;
 				minor = minor >> 1;
 			}
@@ -711,6 +750,25 @@  static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 	td->num_received++;
 }
 
+static void mt_release_pending_palms(struct mt_device *td,
+				     struct input_dev *input)
+{
+	int slotnum;
+	bool need_sync = false;
+
+	for_each_set_bit(slotnum, td->pending_palm_slots, td->maxcontacts) {
+		clear_bit(slotnum, td->pending_palm_slots);
+
+		input_mt_slot(input, slotnum);
+		input_mt_report_slot_state(input, MT_TOOL_PALM, false);
+
+		need_sync = true;
+	}
+
+	if (need_sync)
+		input_sync(input);
+}
+
 /*
  * this function is called when a whole packet has been received and processed,
  * so that it can decide what to send to the input layer.
@@ -719,6 +777,9 @@  static void mt_sync_frame(struct mt_device *td, struct input_dev *input)
 {
 	input_mt_sync_frame(input);
 	input_sync(input);
+
+	mt_release_pending_palms(td, input);
+
 	td->num_received = 0;
 	if (test_bit(MT_IO_FLAGS_ACTIVE_SLOTS, &td->mt_io_flags))
 		set_bit(MT_IO_FLAGS_PENDING_SLOTS, &td->mt_io_flags);
@@ -903,6 +964,13 @@  static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
+	td->pending_palm_slots = devm_kcalloc(&hi->input->dev,
+					      BITS_TO_LONGS(td->maxcontacts),
+					      sizeof(long),
+					      GFP_KERNEL);
+	if (!td->pending_palm_slots)
+		return -ENOMEM;
+
 	ret = input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
 	if (ret)
 		return ret;
```

---
This is important. This means something.

```
2c-19/i2c-DLL06E4:01/0018:06CB:7A13.0001$ cat quirks
72848
mattmayfield@matt-xps-15:/sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-19/i2c-DLL06E4:01/0018:06CB:7A13.0001$ cat uevent
DRIVER=hid-multitouch
HID_ID=0018:000006CB:00007A13
HID_NAME=DLL06E4:01 06CB:7A13
HID_PHYS=i2c-DLL06E4:01
HID_UNIQ=
MODALIAS=hid:b0018g0004v000006CBp00007A13
mattmayfield@matt-xps-15:/sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-19/i2c-DLL06E4:01/0018:06CB:7A13.0001$ echo '72720' | sudo tee quirks
[sudo] password for mattmayfield: 
72720
mattmayfield@matt-xps-15:/sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-19/i2c-DLL06E4:01/0018:06CB:7A13.0001$ cat quirks
72720
mattmayfield@matt-xps-15:/sys/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-19/i2c-DLL06E4:01/0018:06CB:7A13.0001$
```

https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection

https://github.com/torvalds/linux/blob/master/drivers/hid/hid-multitouch.c#L58

/* quirks to control the device */
```
#define MT_QUIRK_NOT_SEEN_MEANS_UP	BIT(0)
#define MT_QUIRK_SLOT_IS_CONTACTID	BIT(1)
#define MT_QUIRK_CYPRESS		BIT(2)
#define MT_QUIRK_SLOT_IS_CONTACTNUMBER	BIT(3)
#define MT_QUIRK_ALWAYS_VALID		BIT(4)
#define MT_QUIRK_VALID_IS_INRANGE	BIT(5)
#define MT_QUIRK_VALID_IS_CONFIDENCE	BIT(6)
**#define MT_QUIRK_CONFIDENCE		BIT(7)**
#define MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	BIT(8)
#define MT_QUIRK_NO_AREA		BIT(9)
#define MT_QUIRK_IGNORE_DUPLICATES	BIT(10)
#define MT_QUIRK_HOVERING		BIT(11)
#define MT_QUIRK_CONTACT_CNT_ACCURATE	BIT(12)
#define MT_QUIRK_FORCE_GET_FEATURE	BIT(13)
#define MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)
#define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
#define MT_QUIRK_STICKY_FINGERS		BIT(16)
#define MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)
```

By default my DLL06E4:01 06CB:7A13 Touchpad is using 72848, which is

MT_QUIRK_NOT_SEEN_MEANS_UP	BIT(0)

MT_QUIRK_SLOT_IS_CONTACTID	BIT(1)

MT_QUIRK_CYPRESS		BIT(2)

MT_QUIRK_SLOT_IS_CONTACTNUMBER	BIT(3)

**MT_QUIRK_ALWAYS_VALID		BIT(4)**

MT_QUIRK_VALID_IS_INRANGE	BIT(5)

MT_QUIRK_VALID_IS_CONFIDENCE	BIT(6)

**MT_QUIRK_CONFIDENCE		BIT(7)**

MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	BIT(8)

MT_QUIRK_NO_AREA		BIT(9)

**MT_QUIRK_IGNORE_DUPLICATES	BIT(10)**

**MT_QUIRK_HOVERING		BIT(11)**

**MT_QUIRK_CONTACT_CNT_ACCURATE	BIT(12)**

MT_QUIRK_FORCE_GET_FEATURE	BIT(13)

MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)

MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)

**MT_QUIRK_STICKY_FINGERS		BIT(16)**

MT_QUIRK_ASUS_CUSTOM_UP		BIT(17)

Turning off bit 7, Confidence, disables palm detection but also eliminates the issue where a palm rest is interpreted as a click. This suggests that the touchpad is reporting the touch (with default confidence bit=1) as the palm drops onto the pad then very quickly turns confidence bit to 0. The kernel interprets that as a press and immediate release, which libinput (or synaptics) counts as a tap to click.
