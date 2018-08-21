# NVidia Optimus

Instead of Bumblebee I'm using the proprietary Prime software installed in Additional Drivers.

## Screen Tearing

As soon as I enabled nVidia graphics I got noticeable screen tearing. To fix, solution from https://ubuntuforums.org/showthread.php?t=2374405&p=13762069#post13762069

1. Create `/etc/modprobe.d/nvidia-drm-modeset.conf` containing one line: `options nvidia-drm modeset=1`
2. Reboot
