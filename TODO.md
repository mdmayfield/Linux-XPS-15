# To Do (libinput)
- Enable two finger scrolling coming from the lower part of the touchpad
  - i.e. disable only tap-to-click in the bottom "button" area

# Back Burner / maybe not do
- Make a Debian package https://www.youtube.com/watch?v=zyRWGzsFdq0 with necessary files
- Enable click zones and click finger both
  - Getting used to click finger

# Done

- Create a more portable keyboard solution
- A type of keyboard to switch to; enable going back and forth
- Port newest libinput to 16.04 and apply no-hysteresis patch
- Allow two-finger scrolling while button is held down

# Not Possible
- Eliminate spurious tap when palm rests solidly (or workaround: properly enable disable while typing)
  - This appears to be hardware/firmware stupidity courtesy of Dell or their touchpad OEM
  - Behavior shows up even in EFI "BIOS" GUI pre-OS boot
  - Some kind of misguided palm detection, implemented beneath the Linux kernel (in touchpad apparently)
  - It registers a touch, then immediately posts a release when it "realizes" it's a palm
  - Really, really stupid of the touchpad devs, since this causes a tap when tap-to-click is on
- Resolve issue with clicks not counting from thumb (delay if held)
  - This appears to be yet more hardware/firmware stupidity
  - Only reason I can imagine is misguided thumb detection implemented in touchpad firmware
  - It appears to "work" (**ha**) similarly to the messed up palm detection above
  - Register a touch, realize it's a thumb, post a release
  - So a physical click would count as a double-click if tap-to-click is on (one tap, one physical)
  - The devs then added an "ultimate moron" layer on top of the stupidity that was already there, by not counting physical presses if the thumb "detection" is triggered
