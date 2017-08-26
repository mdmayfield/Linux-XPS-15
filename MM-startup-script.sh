#!/bin/bash

# Set up trackpad area
xinput set-prop 12 "Synaptics Area" 49 1179 50 878

# Swap modifier keys for Mac-like shortcuts
xmodmap -e "clear control"
xmodmap -e "clear mod1"
xmodmap -e "clear mod4"
xmodmap -e "add control = Alt_L Alt_R"
xmodmap -e "add mod1 = Super_L Control_R"
xmodmap -e "add mod4 = Control_L"
