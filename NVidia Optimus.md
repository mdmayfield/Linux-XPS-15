# NVidia Optimus

Got this to work finally but need to confirm steps / determine what's really needed on next install.

## Currently installed in working system
With "nvidia" in the name or description.
### From Ubuntu repositories:
- bbswitch-dkms
- libcuda1-375
- libvdpau1
- libxnvctrl0
- nvidia-375
- nvidia-opencl-icd-375
- nvidia-prime
- nvidia-settings
- ubuntu-drivers-common
- vdpau-drivers-all
- xserver-xorg-video-noveau

Note that noveau was blacklisted automatically in /etc/modprobe.d/nvidia-graphics-drivers.conf

### From ppa:bumblebee/testing
- bumblebee
- bumblebee-nvidia
- primus

Need to see if the stock versions work. They didn't the first time but I changed a lot of variables when switching.

## Other things
In `/etc/bumblebee/bumblebee.conf` I changed to Driver=nvidia (instead of blank). *Any way to avoid this? This seems like something that should have been set by default.*
Rather than changing the LibraryPath and XorgModulePath, I made a symbolic link from /usr/lib/nvidia-current to /usr/lib/nvidia-375.

## Reinstall 2017-08-27
1. sudo apt-add-repository ppa:bumblebee/testing
- Note: /stable doesn't work. There is no Xenial version so it gives a cryptic error message like `The repository 'http://ppa.launchpad.net/bumblebee/stable/ubuntu xenial Release' does not have a Release file.
N: Data from such a repository can't be authenticated and is therefore potentially dangerous to use.`
2. sudo apt update
3. 
