# Installing Ubuntu MATE 18.04 to my preference

## Done:

- Wiped internal SSD and installed Ubuntu MATE 18.04
- `sudo apt update`; `sudo apt upgrade`
- `sudo apt remove gstreamer1.0-fluendo-mp3` - apparently this is an inferior MP3 decoder, which causes issues with sound quality, and `gstreamer1.0-plugins-ugly` is already capable of playing mp3s.

## To Do:

- Follow https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880 for nVidia stuff
- TLP and PowerTop from same gist
- Mutiny or Cupertino layout
- Report (diagnose?) bug: in Firefox, highlighted text has tops cut off of letters
- Set up Compiz, eliminate all screen tearing, fix top edge flipping shortcut
- Set up xbanish for getting the cursor out of the way of text
- Create ~/.config/gtk-3.0/settings.ini and add `[Settings]     gtk-primary-button-warps-slider = false` because Gtk3 breaks scroll bars (how did anyone think this was a good idea?)
- Set up my own libinput fork (perhaps rebase it on latest)
- Look into kernel patch for Confidence bit on touchpad, or maybe just turn off HW palm detection (Confidence quirk in hid-multitouch)
- Set up keyboard customization, xkb layout and autokey
- Install software and import from backup of ~ on a case-by-case basis (Thunderbird and Firefox profiles mostly)
