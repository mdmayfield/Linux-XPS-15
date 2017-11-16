# Realtime Kernel

Minimum xrun-free JACK buffer size with standard Ubuntu lowlatency kernel: 256 samples @ 44.1kHz

Mainly followed instructions from http://kernel-notes.gbittencourt.net/compiling-preempt-rt/
- Don't bother setting LOCAL_VERSION=rt3 since the existing version is already rt3 and it'll become -rt3-rt3
