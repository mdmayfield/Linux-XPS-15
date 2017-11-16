# Realtime Kernel

Minimum xrun-free JACK buffer size with standard Ubuntu lowlatency kernel: 256 samples @ 44.1kHz

Mainly followed instructions from http://kernel-notes.gbittencourt.net/compiling-preempt-rt/
- Don't bother setting LOCAL_VERSION=rt3 since the existing version is already rt3 and it'll become -rt3-rt3
- By default debug is enabled which takes much longer. https://ubuntuforums.org/showthread.php?t=2266609 scripts/config --disable DEBUG_INFO

Realtime kernel made no difference after compiling. Still can't get lower than 256 x 2 buffer without constant xruns.

- This seems to have been a wild goose chase. It appears to have been the RealTek audio card - with a USB headset I can get down to 2x64 samples with very few xruns (only when seeking in DAW).
