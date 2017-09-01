# Headphones
At first try, plugging in headphones made Alsamixer do all the correct stuff around muting the speakers and un-muting the headphone jack, and Unity brought up a dialog asking if I had plugged in headphones, a headset, or speakers. But no sound came from the headphones.

I'm trying this: https://ubuntuforums.org/showthread.php?t=2332503

i.e. I put this at the end of `/etc/modprobe.d/alsa-base.conf`:

```
# MM added for XPS 15 9550
options snd-hda-intel model=dell-headset-multi
```
