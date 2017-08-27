# General Notes
These are reminders to myself of what to do to set up Ubuntu on my XPS 15 to my liking.

1. Trackpad
  - Use Synaptics driver
  - Inset the active area 50px to avoid palm clicks:
  - `xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Area" 49 1179 50 878`
  - Shrink the right-click soft button area slightly (was 614 0 760 0):
  - `xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Synaptics Soft Button Areas" 800 0 760 0 0 0 0 0`
  - Get used to not resting thumb on trackpad :-(
2. Modifier Keys
  - Use [custom /usr/share/X11/xkb/symbols/pc](https://github.com/mdmayfield/Linux-XPS-15/blob/master/pc)
  - Alt = Ctrl, like Mac Command key
  - LWin and RCtl = Alt, like Mac Option key
  - LCtl = Super, for Windows/Super key
  - Unfortunately this isn't a good solution
  - Things like Cmd-Tab and Cmd-Left/right in browsers don't map to Ctrl
  - As of 2017-08-27, going to try to get used to modifier defaults
  
  ## To Do
  - Obscure cursor when typing in all apps
  - Non-orange theme
  - Create a virtual keypad from m,. jkl uio 789
    - xkb seems to be key (haha) here
  - Get rid of that stupid fscking (literally, lol) text mode /dev/sda1 clean message during bootup
  - Set up bumblebee for Nvidia Optimus to work as needed
  - Get TLP set up and tested and be aware of https://github.com/linrunner/TLP/issues/278
  - Install redshift-gtk for f.lux like functionality

## First Reinstall 2017-08-27
- OOTB, Ubuntu 16.04 with no proprietary drivers or updates while installing
- Graphical garbage/flickering happens immediately on first boot (when resizing Firefox for example)
- Kernel is `4.10.0-28-generic #32~16.04.2-Ubuntu SMP Thu Jul 20 10:19:48 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux`
