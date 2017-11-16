Wine / Reaper were not actually using ALSA directly; the whole time it was an ALSA compatibility layer in PulseAudio so the chain was actually Reaper -> Wine WASAPI -> "ALSA" PA layer -> PulseAudio -> Real ALSA -> hardware.

Switched to Jack and then able to do mostly stable 256 sample buffer, sometimes with xruns and sometimes not (dependent on phase of the moon?). I don't recall seeing any xruns ever on the native version at 256 sample buffer size. Can't go much lower though; 64 causes hundreds of xruns per second even with nothing connected to JACK.

Next going to build a realtime kernel and see if that makes a difference.

---

Seeing a lot of buffer underruns when using ALSA driver in Wine plus WASAPI mode within REAPER, which is weird because that always seemed to work just fine on other computers. For now using PulseAudio driver and WaveOut.

---

Going to try these steps, from https://www.youtube.com/watch?v=E6LuvdDEqCA:

>  - Add your current user to the audio group: sudo adduser username audio
>  - And then give the audio group real time access:
>  - Add this 2 lines to the file: /etc/security/limits.d/audio.conf (You may have to create it)
>  ```
>  @audio - rtprio 99
>  @audio - memlock unlimited
>  ```
