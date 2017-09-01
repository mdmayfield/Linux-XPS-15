# Keyboard Shortcuts
An attempt to adapt my Ubuntu Linux OS to my MacOS keyboard shortcut muscle memory, and not the other way around.

1. Swap modifier keys. Currently my approach is to alter `/usr/share/X11/xkb/symbols/pc` but I'd prefer to do this in ~ somehow.
2. Change keys in Control Center, Unity Tweak Tool, and CompizConfig Settings Manager. (Set switcher to Ctrl-Tab which is physical Alt-Tab)
3. Text editing shortcuts as per something like [this?](http://www.linuxproblem.org/art_17.html)
4. `autokey-gtk` for things like Shift-Cmd-Left/Right for switching tabs in browsers
5. xkb rediect actions - https://superuser.com/questions/585300/how-to-make-control-j-works-as-return-without-control-bit-set-using-xkb-and

# Keyboard Shortcut Plan

## Remapping

### Low Level Symbol Remap:
- Physical LAlt/RAlt become logical LCtl/RCtl
- Physical LWin/RCtl become logical LAlt/RAlt
- Physical LCtl becomes logical Super

### Xkb redirects:
- (Shift)-Ctrl-Tab becomes (Shift)-Alt-Tab
- (Shift)-Super-Tab becomes (Shift)-Ctrl-Tab
- (Shift)-Ctrl-LRUD becomes (Shift)-Alt-LRUD
- (Shift)-Alt-LRUD becomes (Shift)-Ctrl-LRUD

### AutoKey:
- In browsers, Shift-Alt-Left becomes Ctrl-Shift-Tab
- In browsers, Shift-Alt-Right becomes Ctrl-Tab

### Other Settings:
- In Unity Tweak/CompizConfig, "Previous window" becomes Ctrl-\` instead of Alt-Shift-Tab

## Results

### App switching:
- Physical Alt-Tab -> logical Ctrl-Tab -> redirected Alt-Tab
- Physical Alt-Shift-Tab -> logical Ctrl-Shift-Tab -> redirected Alt-Shift-Tab

### Browsers:
- Physical Alt-Left/Right -> logical Ctrl-Left/Right -> redirected Alt-Left/Right
- Physical Shift-Alt-Left -> logical Shift-Ctrl-Left -> redirected Shift-Alt-Left -> AutoKey Ctrl-Shift-Tab
- Physical Shift-Alt-Right -> logical Shift-Ctrl-Right -> redirected Shift-Alt-Right -> AutoKey Ctrl-Tab

### Text Editing:
- Physical (Shift)-LWin/RCtl-LRUD -> logical (Shift)-Alt-LRUD -> redirected (Shift)-Ctrl-LRUD

### File Browser:
- Physical Alt-LRUD -> logical Ctrl-LRUD -> redirected Alt-LRUD

-------

Resources:
https://geekhack.org/index.php?topic=70788.0
https://superuser.com/questions/585300/how-to-make-control-j-works-as-return-without-control-bit-set-using-xkb-and
https://unix.stackexchange.com/questions/236089/transparently-mapping-a-modified-key-with-xkb
https://www.mail-archive.com/i18n@xfree86.org/msg01867.html

** https://stackoverflow.com/questions/32822857/how-to-emulate-integrated-numeric-keypad-cursor-keys-in-linux **
