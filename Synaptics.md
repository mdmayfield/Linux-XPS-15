# Synaptics settings

I'm giving up on trying to duplicate the Apple touchpad. The worst of the spurious clicks can be eliminated with
`Synaptics Area (301):	49, 1179, 50, 878`

That is, either `xinput set-prop "Synaptics Area" 301 49 1179 50 878` or **/etc/X11/xorg.conf** with

```
Section "InputClass"
    Identifier "touchpad"
    MatchDriver "synaptics"
    MatchIsTouchpad "on"
    Option "AreaLeftEdge" "49"
    Option "AreaRightEdge" "1179"
    Option "AreaTopEdge" "50"
    Option "AreaBottomEdge" "878"
EndSection
```

The XPS 15 trackpad is either not noisy, or doesn't seem to need noise reduction. So, to make the trackpad more responsive to smaller movements I am also trying

```
    Option "HorizHysteresis" "0"
    Option "VertHysteresis" "0"
```

AKA `xinput set-prop 12 "Synaptics Noise Cancellation" 0 0`

The Nvidia card setup, which runs at startup, keeps replacing my xorg.conf, so I have decided for now to use the bash commands as Startup Applications, entered in the Unity GUI.

**Going to leave noise cancellation enabled at default, since turning it off interferes with double-clicking.**
