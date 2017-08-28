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
3. sudo apt install nvidia-375
4. sudo apt install bumblebee bumblebee-nvidia primus
- At this point: rebooted. Got login prompt, but then couldn't log in - got sent back to login. Switched to another TTY, researched with Lynx, set prime-select intel. Was able to startx and run nvidia-settings, but it seemed weird... restarted again and was able to log in normally with intel selected. Ran nvidia-settings again, didn't see anything too different. prime-select query returns "unknown". ?!
- sudo prime-select nvidia returns a bunch of stuff...
```
mattmayfield@mm-xps-15:/etc/bumblebee$ sudo prime-select nvidia
Info: the current GL alternatives in use are: ['mesa', 'mesa']
Info: the current EGL alternatives in use are: ['mesa-egl', 'nvidia-375-prime']
Info: selecting nvidia-375 for the nvidia profile
update-alternatives: using /usr/lib/nvidia-375/ld.so.conf to provide /etc/ld.so.conf.d/x86_64-linux-gnu_GL.conf (x86_64-linux-gnu_gl_conf) in manual mode
/sbin/ldconfig.real: /usr/lib/nvidia-375/libEGL.so.1 is not a symbolic link

/sbin/ldconfig.real: /usr/lib32/nvidia-375/libEGL.so.1 is not a symbolic link

update-alternatives: using /usr/lib/nvidia-375/ld.so.conf to provide /etc/ld.so.conf.d/x86_64-linux-gnu_EGL.conf (x86_64-linux-gnu_egl_conf) in manual mode
/sbin/ldconfig.real: /usr/lib/nvidia-375/libEGL.so.1 is not a symbolic link

/sbin/ldconfig.real: /usr/lib32/nvidia-375/libEGL.so.1 is not a symbolic link

update-alternatives: using /usr/lib/nvidia-375/alt_ld.so.conf to provide /etc/ld.so.conf.d/i386-linux-gnu_GL.conf (i386-linux-gnu_gl_conf) in manual mode
/sbin/ldconfig.real: /usr/lib/nvidia-375/libEGL.so.1 is not a symbolic link

/sbin/ldconfig.real: /usr/lib32/nvidia-375/libEGL.so.1 is not a symbolic link

update-alternatives: using /usr/lib/nvidia-375/alt_ld.so.conf to provide /etc/ld.so.conf.d/i386-linux-gnu_EGL.conf (i386-linux-gnu_egl_conf) in manual mode
/sbin/ldconfig.real: /usr/lib/nvidia-375/libEGL.so.1 is not a symbolic link

/sbin/ldconfig.real: /usr/lib32/nvidia-375/libEGL.so.1 is not a symbolic link
```
According to https://askubuntu.com/questions/900285/libegl-so-1-is-not-a-symbolic-link this should be resolved with `sudo dpkg-reconfigure nvidia*`
I did not do anything like that - sounds like * isn't interpreted by dpkg-reconfigure but that the user has to do it. So forget it for now.
Latest error after changing bumblebee.conf and restarting is `[   93.421525] [ERROR]The Bumblebee daemon has not been started yet or the socket path /var/run/bumblebee.socket was incorrect.
[   93.421577] [ERROR]Could not connect to bumblebee daemon - is it running?`
I think I need to do `sudo systemctl enable bumblebeed` - trying that followed by `sudo service bumblebeed start`. No luck; also after restart same error.

Running "bumblebeed" by itself shows errors:
```
[  103.812601] [ERROR]Module 'bbswitch' not found.
[  103.812635] [WARN]No switching method available. The dedicated card will always be on.
[  103.812725] [ERROR]Module 'nvidia' is not found.
```
Looks like this may have to do with not having Linux headers... running `sudo apt install linux-headers-lowlatency-hwe-16.04-edge` ... Progress. After installing those the only error running bumblebeed is `[ERROR]Module 'nvidia' is not found.`

That seems to be because in bumblebee.conf, the KernelDriver was set to "nvidia" but there was no module called that. After changing KernelModule=nvidia-375, the error changes to `[ERROR]Cannot open or write pidfile /var/run/bumblebeed.pid.`

Guessing this has to do with my user not being in the right group. Researching...
