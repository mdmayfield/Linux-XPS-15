# Bluetooth
According to `dmesg | grep failed`:
```
bluetooth hci0: Direct firmware load for brcm/BCM-0a5c-6410.hcd failed with error -2
```
- Based on https://ubuntuforums.org/showthread.php?t=2317843 - need the firmware, BCM-0a5c-6410.hcd
- This was available via Dropbox
- Copy to  /lib/firmware/brcm/ and reboot
- Low battery (~1V ea) confused this issue too - prevented successful pairing. Make sure to use fresh batteries!
