On new desktop, trying to configure realtimeconfigquickscan. Audio is a *big* pain. Jack sporadically just doesn't work.


Took this from https://linuxmusicians.com/viewtopic.php?t=2191 + https://unix.stackexchange.com/questions/333697/etc-udev-rules-d-vs-lib-udev-rules-d-which-to-use-and-why
```
create /etc/udev/rules.d/40-rtc-permissions.rules - contents:

KERNEL=="rtc0", GROUP="audio"
KERNEL=="hpet", GROUP="audio"
```

Took this from https://linuxmusicians.com/viewtopic.php?f=27&t=844
```
for x in $( seq 0 7 ); do sudo cpufreq-set -c $x -g performance; done
```


So far best success is with the above cpufreq-set, and rtirq with `RTIRQ_NAME_LIST="usb i8042"`, plus install RT kernel from Debian: https://packages.debian.org/sid/amd64/linux-image-5.2.0-1-rt-amd64-unsigned/download

Seeing xruns of the "soft" (?) type, in parenthesis, on Reaper when doing pitch shift FX, but PulseAudio (FireFox/YouTube) continues uninterrupted. Almost no "hard" xruns even at 3x32 buffer.






https://www.systutorials.com/241533/how-to-force-a-usb-3-0-port-to-work-in-usb-2-0-mode-in-linux/
Trying to force the USB ports to EHCI (2.0) driver mode instead of xHCI (3.0)

Streaks of xrun issues always correspond with this in `dmesg`
```
[Sun Aug 11 17:51:36 2019] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 2 ep 2 with no TDs queued?
[Sun Aug 11 17:53:26 2019] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 2 ep 4 with no TDs queued?
```
