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
