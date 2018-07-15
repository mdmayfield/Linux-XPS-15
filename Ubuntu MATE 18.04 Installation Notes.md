# Installing Ubuntu MATE 18.04 to my preference

## Done:

- Wiped internal SSD and installed Ubuntu MATE 18.04
- `sudo apt update`; `sudo apt upgrade`
- `sudo apt remove gstreamer1.0-fluendo-mp3` - apparently this is an inferior MP3 decoder, which causes issues with sound quality, and `gstreamer1.0-plugins-ugly` is already capable of playing mp3s.
- `sudo apt install tlp tlp-rdw powertop`; `sudo tlp start`
  - Need to run `sudo powertop` for quite some time on battery power to get a reading
  - After this, `sudo powertop --auto-tune`
  - Note while doing this - powertop is showing only around 4 watts discharge when idle. Better than I usually saw in 16.04; maybe newer kernel helps?
- `sudo apt install build-essential git x11proto-core-dev libx11-dev libxt-dev libxfixes-dev libxi-dev`  
- `git config --global user.email "mdmayfield@users.noreply.github.com"`; `git config --global user.name "Matt Mayfield"`
- Make and install xbanish:
  - `mkdir ~/Developer`; `cd ~/Developer`; `git clone https://github.com/mdmayfield/xbanish.git`; `cd xbanish`
  - `make` xbanish then `sudo cp xbanish /usr/local/bin/`
  - To run: `xbanish -i Shift -i Control -i mod1 -i mod4 &` and put that line in `~/.xsessionrc` to run at startup
- Create ~/.config/gtk-3.0/settings.ini and add `[Settings]     gtk-primary-button-warps-slider = false` because Gtk3 breaks scroll bars (how did anyone think this was a good idea?)
- Turn off Super key to open menu in preparation for keyboard layout shenanigans:
``gsettings set org.mate.mate-menu hot-key ''
gsettings set com.solus-project.brisk-menu hot-key ''``
- Install extra codecs, fonts: `sudo apt install libavcodec-extra unrar`; `sudo apt install ttf-mscorefonts-installer`; `sudo apt install gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly`
- Set up printer (which was *ridiculously* easy; it was already automatically detected)
- Go to Software Sources and enable Source Code repo
- Set up Time And Date control panel to keep sync with Internet time servers. First `sudo apt install ntp` then change Control Panel. (Why on Earth don't they install ntp automatically, or at least give a newbie-friendly error message? I knew what to do but a new user wouldn't.)
- Touchpad control panel - set up horiz + vert scrolling, and two- and three-finger click/tap. (will still tweak with xinput settings in .xsessionrc)
- In MATE Tweak, select Cupertino layout, then (because I don't want the full-screen Brisk Menu): `gsettings set com.solus-project.brisk-menu window-type 'classic'`
- Set Plank theme: Matte
- Configure HUD: `gsettings set org.mate.hud shortcut '<Super>space'` then enable in MATE Tweak
- Set menubar clock to 12h and US units: right-click
- `sudo apt install compizconfig-settings-manager` then choose Compiz as compositor from MATE Tweak
- Compiz fixes/tweaks - install profile Linux-XPS-15/UbuntuMATE1804CompizDefaults180713.profile, or do these:
  - In Commands, Command line 1, remove `--interactive` so that Shift-PrintScreen doesn't show the unnecessary dialog.
  - In General Options, use:
  ```
  s0_close_window_key = <Super>q
  s0_close_window_button = Disabled
  s0_raise_window_key = Disabled
  s0_raise_window_button = Disabled
  s0_lower_window_key = Disabled
  s0_lower_window_button = Disabled
  s0_minimize_window_key = <Control>h
  s0_minimize_window_button = Disabled
  s0_maximize_window_key = <Super>Up
  s0_unmaximize_window_key = Disabled
  s0_unmaximize_or_minimize_window_key = <Super>Down
  s0_maximize_window_horizontally_key = Disabled
  s0_maximize_window_vertically_key = Disabled
  s0_window_menu_key = <Alt>space
  s0_window_menu_button = Disabled
  s0_show_desktop_key = <Super>d
  s0_show_desktop_edge = 
  s0_toggle_window_maximized_key = Disabled
  s0_toggle_window_maximized_button = Disabled
  s0_toggle_window_maximized_horizontally_key = Disabled
  s0_toggle_window_maximized_vertically_key = Disabled
  s0_toggle_window_shaded_key = Disabled
  s0_hsize = 3
  s0_vsize = 2
  ```
  - In Desktop Wall:
    - Turn off all four options in Bindings -> Edge Flipping. This fixes an issue with the Global Menu not rolling over on the top pixel of the screen.
    - EXPERIMENTAL: In Viewport Switching, set Multimonitor behavior to Switch Separately
    - Set keyboard bindings to Super-Ctrl (becomes Alt with custom keymap, which becomes Ctrl) arrows for navigation, and Super-Ctrl-Shift arrows for moving a window
  - In Expo ISSUE: currently <Super>s is swallowed by indicator-applet-complete. See To Do item. Temporary workaround: set shortcut to <Super>grave
  - Disable Application Switcher, enable Static Application Switcher:
    - Ctrl-Tab for next window (all windows), Ctrl-\` for previous window (all windows)
    - Behavior turn off Auto Change Viewport
    - Appearance Saturation/Brightness/Opacity each 60%
  - Move Window: Initiate Window Move -> <Super><Alt>
  - Grid: just <Super> not <Super><Control> for Left Maximize and Right Maximize. Top Maximize, Bottom do nothing.
- Put Linux-XPS-15/custom keymap in ~/.xkb, and add `xkbcomp $HOME/.xkb/custom $DISPLAY` to `~/.xsessionrc`. *Not sure why this seems to work on Ubuntu MATE 18.04 when it does not work on Ubuntu Unity 16.04. Also pleased to discover that the keymap sticks around even after plugging in USB headset, which it did not in 16.04.*
- `sudo apt install autokey-gtk`; run Autokey, quit. Swap in `autokey/data` for `~/.config/autokey/data`. Manually add it to Startup Items. Tried the command `(autokey &)` to avoid the issue where Ctrl-N on desktop pops up both ~ and the AutoKey config window; didn't work. Instead, for script within AutoKey, using `dbus-send --session --type=method_call --dest="org.freedesktop.FileManager1" "/org/freedesktop/FileManager1" "org.freedesktop.FileManager1.ShowFolders" array:string:"file://$HOME" string:""`
- Replace ~/.mozilla/firefox folder with backup from previous installation
- Add to ~/.profile: `# enable smooth scrolling in Firefox  \n  export MOZ_USE_XINPUT2=1` (doesn't take effect right away even if you . .profile; need to log out/in, or start FF from terminal while setting that var)
- In `/etc/dbus-1/system.d/org.freedesktop.UPower.conf`, change `<allow send_destination="org.freedesktop.UPower" send_interface="org.freedesktop.UPower.KbdBacklight"/>` to `deny`.
  - This keeps the keyboard backlight from constantly turning itself on randomly.
  - Note that there are two similar entries; read carefully. On my install the correct one was near the end.
- Disable the annoying sound when plugging in or unplugging the AC adapter: `gsettings set org.mate.power-manager enable-sound false`
- Turn off terminal bell: MATE Terminal -> Edit -> Profile Preferences
- Turn off Bluetooth at system startup: create `/etc/rc.local` and make it executable - systemd will run it. This is the same as doing "Turn Bluetooth Off" and it can be turned back on by the applet:
  ```
  #!/bin/bash
  rfkill block bluetooth
  exit 0
  ```
- Had to re-copy Bluetooth firmware to `/lib/firmware/brcm/`; see Bluetooth.md 
- `sudo apt remove vlc`; `sudo snap install vlc`. VLC 3.0.2 has issues with timeline tooltips causing flickering (and also vala-panel-appmenu crashes).
- Install libinput touchpad driver from source (upstream is much better as of this writing; only customizations remaining are to allow two-finger scrolling and three-finger gestures while mouse button is held down, and immediately assume the bottom few mm of the touchpad is a thumb)
```
sudo apt build-dep libinput
sudo apt install ninja-build meson doxygen graphviz libgtk-3-dev check valgrind libunwind-dev
cd Developer/
git clone https://github.com/mdmayfield/libinput.git
cd libinput/
meson . builddir
ninja -C builddir
sudo ninja install -C builddir
cd /etc/ld.so.conf.d/
echo '/usr/local/lib/x86_64-linux-gnu' | sudo tee -a usr-local-lib.conf
sudo ldconfig
```  
- Set up libinput-gestures:
  - `sudo gpasswd -a $USER input` to add self to input group
  - `sudo apt install xdotool wmctrl`
  - Since I compiled my own libinput the tools are pre-installed. If I hadn't and were using libinput from the repo, I would also `sudo apt install libinput-tools`.
  - `cd ~/Developer`; `git clone https://github.com/bulletmark/libinput-gestures.git`; `cd libinput-gestures`; inspect scripts for anything funky; `sudo make install`
  - in `~/.config/libinput-gestures.conf`:
  ```
  gesture swipe up	xdotool key super+alt+Up
  gesture swipe down	xdotool key super+alt+Down
  gesture swipe left	xdotool key super+alt+Left
  gesture swipe right	xdotool key super+alt+Right
  ```
  - `libinput-gestures-setup autostart` to automatically run at login; `libinput-gestures-setup start` to run now
- Install custom mate-indicator-applet with no hotkeys from source.
  - `cd ~/Developer`; `git clone https://github.com/mdmayfield/mate-indicator-applet.git`; `cd mate-indicator-applet`
  - `sudo apt build-dep mate-indicator-applet`; `./autogen.sh --with-ubuntu-indicators`; `make`; `sudo make install`
  - Log out/in or restart

## To Do:

- Follow https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880 for nVidia stuff
- Report (diagnose?) bug: in Firefox, highlighted text has tops cut off of letters
- Look into kernel patch for Confidence bit on touchpad, or maybe just turn off HW palm detection (Confidence quirk in hid-multitouch)
- Install software and import from backup of ~ on a case-by-case basis (Thunderbird and Firefox profiles, VirtualBox machines)
- Set up KXStudio and determine if lowlatency or realtime kernel is needed
- Custom brightness to go to 1 instead of 0
- Eliminate <Super>-S hotkey from mate-indicator-applet-complete (crashes when I press it? Also prevents Compiz from receiving the shortcut)
- Set up audio stuff
- Find a way to reduce the amount of logging that AutoKey does https://docs.python.org/2/library/logging.html  autokey/lib/autokey/gtkapp.py
- Figure out weirdness with alert volume
- Space bar preview (Gloobus, Sushi... but would be nicer with arrows)
- File content index search
- Clean up fonts list; disable or remove fonts from other locales (why on Earth are there 50 duplicates of Noto for various places? Wasn't Unicode supposed to solve this?)
- Consider using Compiz Scale (all windows) instead of Static Application Switcher
