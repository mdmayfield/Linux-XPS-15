# Installing Ubuntu MATE 18.04 to my preference

## Done:

- Wiped internal SSD and installed Ubuntu MATE 18.04
- `sudo apt update`; `sudo apt upgrade`
- `sudo apt remove gstreamer1.0-fluendo-mp3` - apparently this is an inferior MP3 decoder, which causes issues with sound quality, and `gstreamer1.0-plugins-ugly` is already capable of playing mp3s.
- `sudo apt install tlp tlp-rdw powertop`; `sudo tlp start`
  - Need to run `sudo powertop` for quite some time on battery power to get a reading
  - After this, `sudo powertop --auto-tune`
  - Note while doing this - powertop is showing only around 4 watts discharge when idle. Better than I usually saw in 16.04; maybe newer kernel helps?
- Make and install xbanish:
  - `sudo apt install build-essential git x11proto-core-dev libx11-dev libxt-dev libxfixes-dev libxi-dev`
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
- Compiz fixes/tweaks:
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
    - Set keyboard bindings to Super-Alt arrows for navigation, and Super-Alt-Shift arrows for moving a window
  - In Expo ISSUE: currently <Super>s is swallowed by indicator-applet-complete. See To Do item. Temporary workaround: set shortcut to <Super>grave
  - Disable Application Switcher, enable Static Application Switcher:
    - Ctrl-Tab for next window (all windows), Ctrl-\` for previous window (all windows)
    - Behavior turn off Auto Change Viewport
    - Appearance Saturation/Brightness/Opacity each 60%
  - Move Window: Initiate Window Move -> <Super><Alt>
  - Grid: just <Super> not <Super><Control> for Left Maximize and Right Maximize. Top Maximize, Bottom do nothing.
  
  

## To Do:

- Follow https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880 for nVidia stuff
- Report (diagnose?) bug: in Firefox, highlighted text has tops cut off of letters
- Set up my own libinput fork (perhaps rebase it on latest)
- Look into kernel patch for Confidence bit on touchpad, or maybe just turn off HW palm detection (Confidence quirk in hid-multitouch)
- Set up keyboard customization, xkb layout and autokey
- Install software and import from backup of ~ on a case-by-case basis (Thunderbird and Firefox profiles, VirtualBox machines)
- Set up KXStudio and determine if lowlatency or realtime kernel is needed
- Custom brightness to go to 1 instead of 0
- Eliminate <Super>-S hotkey from mate-indicator-applet-complete (crashes when I press it? Also prevents Compiz from receiving the shortcut)
- Manage other system keyboard shortcuts
