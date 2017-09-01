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
