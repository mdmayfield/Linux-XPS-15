# Headphones

Most recently, after losing headphones I restarted and went into EFI Setup and disabled the internal speakers. Started up again, tested headphones (worked), restarted into EFI and re-enabled speakers, then started up again (w/headphones connected in case that matters), and everything went back to working.

---

Lost headphones at one point; though this would help but then it went back to not working:
```
1) Install:
sudo apt-get install alsa-tools-gui

2) Launch:
hdajackretask

3) Check 'Show unconnected pins'

4) Check "override" on 0x21.

5) Apply; test sound.

6) If everything all is good now, press "install boot override"
```

From https://www.mail-archive.com/search?l=ubuntu-bugs@lists.ubuntu.com&q=subject:%22%5C%5BBug+1575078%5C%5D+Re%5C%3A+%5C%5BXPS+15+9550%2C+Realtek+ALC3266%5C%5D+Headphone+jack+stops+working+after+a+while%22&o=newest&f=1


---

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

After again suspending and resuming, this time *without* headphones connected, the headphones continue to work correctly when plugged in.
