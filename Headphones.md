# Headphones
At first try, plugging in headphones made Alsamixer do all the correct stuff around muting the speakers and un-muting the headphone jack, and Unity brought up a dialog asking if I had plugged in headphones, a headset, or speakers. But no sound came from the headphones.

I'm trying this: https://ubuntuforums.org/showthread.php?t=2332503

i.e. I put this at the end of `/etc/modprobe.d/alsa-base.conf`:

```
# MM added for XPS 15 9550
options snd-hda-intel model=dell-headset-multi
```
---

Nope, that didn't work. Continuing to research.

---
## Workaround

After making that change, I tried putting the laptop to sleep (closing lid) *while headphones were connected*. I heard a click in the headphones, then opened the laptop again and sound played through the headphones. After this, headphone plug/unplug seems to work fully as expected.

Note that I don't know whether the above change to alsa-base.conf was actually part of the solution or not, yet.
