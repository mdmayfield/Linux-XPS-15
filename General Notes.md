# General Notes
These are reminders to myself of what to do to set up Ubuntu on my XPS 15 to my liking.

1. Trackpad
  - Use custom patched libinput driver with patches for
     - Disabling movement hysteresis
     - Allowing clickpad click to count even with no fingers sensed
     - Immediately counting any touch in button area as a thumb (reduces sporadic clicks)
     - Decreasing cursor jump threshold to eliminate jumps after 1-second delay
  - Add these settings in .xsessionrc:
  ```
# For Libinput driver
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "Coordinate Transformation Matrix" 0.6 0 0 0 0.6 0 0 0 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Accel Speed" 0.75
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1
  ```
  - Use AutoKey shortcuts as listed in this repo
2. Modifier Keys
  - Use changes as outlined in `Keyboard Shortcuts.md`
  - TODO: Make this a switchable keyboard profile instead of edits to system files
  - TODO: Create a virtual keypad from m,. jkl uio 789

3. Email: Thunderbird
4. Calendar: MineTime
