# Synaptics settings

I'm giving up on trying to duplicate the Apple touchpad. The worst of the spurious clicks can be eliminated with
`Synaptics Area (303):	49, 1179, 50, 878`

That is, either

`xinput set-prop 12 303 49 1179 50 878`

or **/etc/X11/xorg.conf** with

`Section "InputClass"
    Driver "synaptics"
    MatchIsTouchpad "on"
    Option "AreaLeftEdge" "49"
    Option "AreaRightEdge" "1179"
    Option "AreaTopEdge" "50"
    Option "AreaBottomEdge" "878"
EndSection`
