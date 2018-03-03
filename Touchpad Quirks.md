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
