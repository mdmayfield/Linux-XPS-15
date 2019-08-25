For Pulse, used these at the end of `~/.config/pulse/default.pa`:

```
load-module module-remap-sink sink_name=Focusrite_stereo channels=2 master=alsa_output.usb-Focusrite_Scarlett_18i20_USB_03018219-00.multich>
set-default-sink Focusrite_stereo
set-default-source alsa_input.usb-Focusrite_Scarlett_18i20_USB_03018219-00.multichannel-input
```



----

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


This isn't actually necessary; same problems with or without realtime kernel

Streaks of xrun issues always correspond with this in `dmesg`
```
[Sun Aug 11 17:51:36 2019] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 2 ep 2 with no TDs queued?
[Sun Aug 11 17:53:26 2019] xhci_hcd 0000:00:14.0: WARN Event TRB for slot 2 ep 4 with no TDs queued?
```




https://www.systutorials.com/241533/how-to-force-a-usb-3-0-port-to-work-in-usb-2-0-mode-in-linux/
Trying to force the USB ports to EHCI (2.0) driver mode instead of xHCI (3.0)
>On Linux on some platforms in BIOS modes, you can use the following command to force USB 2.0 modes for your USB ports:
>```
>lspci -nn | grep USB 
>| cut -d '[' -f3 | cut -d ']' -f1 
>| xargs -I@ setpci -H1 -d @ d0.l=0
>```
>Following is an explanation of what the commands do.
>
>The controllers have a register XUSB2PR – xHC USB 2.0 Port Routing Register – at address 0xd0 (check http://www.intel.com/content/www/us/en/chipsets/7-series-chipset-pch-datasheet.html for more details). When the XUSB2PR register is set to 0, it routes all the corresponding USB 2.0 port pins to the EHCI controller and RMH #1. The USB 2.0 port is masked from the xHC and the USB 2.0 port’s OC pin is routed to the EHCI controller. The command setpci -H1 -d @ d0.l=0 does this.
>
>setpci needs the vendor and device ID. So the first 2 lines find all USB controller’s IDs and pass them to xargs to invoke setpci.
>
>If you would like to do the settings manually, one example is as follows for your reference:
>```
># lspci -nn | grep USB
>00:14.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI [8086:8c31] (rev 05)
>00:1a.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #2 [8086:8c2d] (rev 05)
>00:1d.0 USB controller [0c03]: Intel Corporation 8 Series/C220 Series Chipset Family USB EHCI #1 [8086:8c26] (rev 05)
>
># setpci -H1 -d 8086:8c31 d0.l=0
># setpci -H1 -d 8086:8c26 d0.l=0
># setpci -H1 -d 8086:8c2d d0.l=0
>```
