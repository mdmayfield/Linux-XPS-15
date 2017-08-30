# Audacity

The .desktop file for Audacity, `/usr/share/applications/audacity.desktop`, has as its execute command `Exec=env UBUNTU_MENUPROXY=0 audacity %F`. Apparently this was a workaround for some kind of bug at one point. As a result, Audacity's menus do not show up in the Unity global menu. To fix, change UBUNTU_MENUPROXY=0 to =1 (or perhaps remove the env U_M altogether).
