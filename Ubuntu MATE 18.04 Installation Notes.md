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


## To Do:

- Follow https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880 for nVidia stuff
- Mutiny or Cupertino layout
- Report (diagnose?) bug: in Firefox, highlighted text has tops cut off of letters
- Set up Compiz, eliminate all screen tearing, fix top edge flipping shortcut
- Set up my own libinput fork (perhaps rebase it on latest)
- Look into kernel patch for Confidence bit on touchpad, or maybe just turn off HW palm detection (Confidence quirk in hid-multitouch)
- Set up keyboard customization, xkb layout and autokey
- Install software and import from backup of ~ on a case-by-case basis (Thunderbird and Firefox profiles, VirtualBox machines)
- Set up KXStudio and determine if lowlatency or realtime kernel is needed
- Custom brightness to go to 1 instead of 0
- Eliminate <Super>-S hotkey from mate-indicator-applet-complete (crashes when I press it? Also prevents Compiz from receiving the shortcut)
