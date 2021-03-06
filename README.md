# Linux stuff for Dell XPS 15 9550

## Installing the OS
This assumes regular vanilla Ubuntu 16.04 LTS. I installed (off a 4GB SD card, of all things) without downloading updates during installation, and without proprietary drivers or Flash (ecch) etc. Note that my XPS 15 has a Broadcom wireless chipset, not the "killer" brand one that apparently a few XPSes do.

## Making the Touchpad Better
Using my fork of https://github.com/mdmayfield/libinput
and these lines in .xsessionrc:
```
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Accel Speed" 1
xinput set-prop "DLL06E4:01 06CB:7A13 Touchpad" "libinput Tapping Enabled" 1
```
The main things I'd like to improve from here are:
- 100% reliably reject palm/thumb touched that rest instead of counting them as touch & release
- Allow for two-finger scrolling while dragging

## Enabling Bluetooth
Out-of-the-box, Ubuntu 16.04.3 at least doesn't work properly with my XPS 15's Bluetooth. YMMV. Apparently, as mentioned on the [Ubuntu forums](https://ubuntuforums.org/showthread.php?t=2317843), there is a missing firmware file.
- Copy [BCM-0a5c-6410.hcd]( BCM-0a5c-6410.hcd ) to **/lib/firmware/brcm/**
- Changes will take effect after reboot
- Reboot can probably be done just once, after doing other steps in this guide too (I didn't test)

## Eliminating Graphical Glitches (Scrambled Images, Flickering)
Installing the `linux-image-lowlatency-hwe-16.04-edge` kernel seemed to fix this. I imagine that the regular `linux-image-hwe-16.04-edge` kernel would also fix it, but I have not tested this as of this writing.

- `sudo apt install linux-image-lowlatency-hwe-16.04-edge`
- If using NVidia Optimus (below), must also install headers: `sudo apt install linux-headers-lowlatency-hwe-16.04-edge`
- Changes take effect after reboot
- Reboot can probably be done just once, after doing other steps in this guide too (I didn't test)

## Enabling NVidia Optimus Graphics Card Switching
In Windows, Optimus aims to use the Intel Integrated Graphics (lower battery usage) for most of the time, but power up and switch to the NVidia discrete graphics card (higher performance) when needed.

In Linux, this is slightly more of a manual process and community devs are still working the bugs out as of this writing. I got my XPS 15 9550 with a GeForce GTX 960M to work using these steps. *Work in progress. **Warning:** restarting between some of these steps may leave you unable to log into the GUI! Resolution will require Ctrl-Alt-F1 to switch to a text terminal and (usually) fixing settings in /etc/bumblebee/bumblebee.conf*

- `sudo apt-add-repository ppa:bumblebee/testing`
- `sudo apt update`
- `sudo apt install nvidia-375` *note: there may be a newer version. can check with apt search*
- `sudo apt install bumblebee bumblebee-nvidia primus`
- Edit `/etc/bumblebee/bumblebee.conf`:
  - **line 22** change `Driver=` to `Driver=nvidia`
  - **line 57** change `KernelDriver=` to `KernelDriver=nvidia-375` (or other version number as needed to match above)
- Create link so /usr/lib/nvidia-current points to /usr/lib/nvidia-375 (or other):
  - `sudo ln -s /usr/lib/nvidia-375 /usr/lib/nvidia-current`
  - `sudo ln -s /usr/lib32/nvidia-375 /usr/lib32/nvidia-current`
- Enable the bumblebeed service:
  - `sudo systemctl enable bumblebeed`
- Make the kernel load the Intel and bbswitch modules. `sudo nano /etc/modules` and add these lines:
```
i915
bbswitch
```
- `sudo prime-select intel` so that the Intel card is default
- Changes take effect after reboot. Good luck.
- To run a program with the discrete graphics card, prefix its command line with `optirun` or `primusrun`
- My first impression is that primusrun is faster, but need to do further testing

## Installing Proprietary Codecs Etc. Without Flash Player
```
sudo apt update
sudo apt install libavcodec-extra ttf-mscorefonts-installer unrar
sudo apt install gstreamer1.0-fluendo-mp3 gstreamer1.0-libav gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly oxideqt-codecs-extra
```
As per https://askubuntu.com/questions/97264/how-to-install-ubuntu-restricted-extras-but-not-flash
