This was really frustrating. To get PulseAudio to only output stereo sound to my USB multichannel sound device, I had to put this in `~/.config/pulse/default.pa`:

```
# MM: No matter what we want 2-channel. Multichannel does not mean 7.1!
load-module module-remap-sink sink_name=Focusrite_stereo channels=2 master=alsa_output.usb-Focusrite_Scarlett_18i20_USB_03018219-00.multichannel-output master_channel_map=front-left,front-right channel_map=left,right remix=no
```
