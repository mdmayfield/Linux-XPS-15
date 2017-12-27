# Compiling libinput

As experimenting on Ubuntu MATE 17.10
```
Enable source code in Software Sources
sudo apt build-dep libinput
sudo apt install ninja-build meson doxygen graphviz libgtk-3-dev check valgrind libunwind-dev
cd ~/Developer/libinput
meson . builddir
ninja -C builddir
sudo ninja install -C builddir

# set up library path to include /usr/local/lib/x86_64-linux-gnu/. Otherwise the custom version will never be loaded.
cd /etc/ld.so.conf.d
echo '/usr/local/lib/x86_64-linux-gnu' | sudo tee -a usr-local-lib.conf
sudo ldconfig
```

## Add to .xsessionrc
```
#!/bin/sh

xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Accel Speed" 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Click Method Enabled" 1 0

# Re-enable repeats disabled by redirect actions
#xset r 113 #Left
#xset r 114 #Right
#xset r 111 #Up
#xset r 116 #Down
#xset r 22  #Backspace

# Hide mouse cursor while typing
xbanish -i Shift -i Control -i mod1 -i mod4 &
```
Then set the mouse control panel for horizontal scrolling allowed, no vertical edge scrolling, and max acceleration

`gsettings set com.solus-project.brisk-menu label-visible false` to hide "Menu" from Brisk Menu

## Keyboard shortcuts

```
sudo apt install autokey-gtk git
git config --global user.email "mdmayfield@users.noreply.github.com"
git config --global user.name "Matt Mayfield"
cd ~/.config
git clone https://github.com/mdmayfield/autokey.git
cd ~
git clone https://github.com/mdmayfield/xkb.git .xkb
#Set up AutoKey to run at startup with GUI
#Use command in command-reference for modifier swap etc.
```

Problem: MATE seems to intercept modifier keys before everything else, so that keyboard shortcuts for things like the HUD are triggering on the wrong (as-labeled) keys instead of the customized ones.
