On new desktop, trying to configure realtimeconfigquickscan. Audio is a *big* pain. Jack sporadically just doesn't work.


Took this from https://linuxmusicians.com/viewtopic.php?t=2191
```
So I create a new 40-rtc-permissions.rules file in /lib/udev/rules.d
where I put the following line:

KERNEL=="rtc0", GROUP="audio"
```

Took this from https://linuxmusicians.com/viewtopic.php?f=27&t=844
```
for x in $( seq 0 7 ); do sudo cpufreq-set -c $x -g performance; done
```
