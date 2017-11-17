# Keyboard Shortcuts

Update 2017-11-16:

No need for replacing system-level files. Instead, just need to place this in arbitrary place in home directory (I'm using `~/.xkb/custom`):

```
xkb_keymap {
	xkb_keycodes  { include "evdev+aliases(qwerty)"	};
	xkb_types     { include "complete"	
		type "CMD_OPT_HELD" {
		  modifiers = Alt+Control;
		  map[None] = Level1;
		  map[Alt] = Level2;
		  map[Control] = Level3;
		  map[Alt+Control] = Level4;
		  level_name[Level1] = "Base";
		  level_name[Level2] = "Alt";
		  level_name[Level3] = "Control";
		  level_name[Level4] = "Alt+Control";
		};
	};
	xkb_compat    { include "complete"	};
	xkb_symbols   { include "pc+us+inet(evdev)+compose(menu)"	

		// MM custom modifiers for XPS 15
		replace key <LALT> { [ Control_L, Control_L ] };
		replace key <LWIN> { [ Alt_L, Meta_L ] };
		replace key <LCTL> { [ Super_L ] };
		replace key <RALT> { [ Control_R, Control_R ] };
		replace key <RCTL> { [ Alt_R ] };

	   replace key <BKSP> {
	      type = "CMD_OPT_HELD",
	      symbols[Group1] = [ BackSpace, BackSpace, BackSpace, BackSpace ],
	      actions[Group1] = [ RedirectKey(key=<BKSP>,clearmods=Control+Mod1),
		 RedirectKey(key=<BKSP>,clearmods=Control+Mod1,modifiers=Control),
		 RedirectKey(key=<BKSP>,clearmods=Control+Mod1,modifiers=Mod1),
		 NoAction() ]
	    };

            replace key <UP> {
	      type = "CMD_OPT_HELD",
	      symbols[Group1] = [ Up, Up, Up, Up ],
	      actions[Group1] = [ RedirectKey(key=<UP>,clearmods=Control+Mod1),
		 RedirectKey(key=<UP>,clearmods=Control+Mod1,modifiers=Control),
		 RedirectKey(key=<UP>,clearmods=Control+Mod1,modifiers=Mod1),
		 NoAction() ]
	    };

	    replace key <LEFT> {
	      type[Group1] = "CMD_OPT_HELD",
	      symbols[Group1] = [ Left, Left, Left, Left ],
	      actions[Group1] = [ RedirectKey(key=<LEFT>,clearmods=Control+Mod1),
		 RedirectKey(key=<LEFT>,clearmods=Control+Mod1,modifiers=Control),
		 RedirectKey(key=<LEFT>,clearmods=Control+Mod1,modifiers=Mod1),
		 NoAction() ]
	    };

	    replace key <DOWN> {
	      type = "CMD_OPT_HELD",
	      symbols[Group1] = [ Down, Down, Down, Down ],
	      actions[Group1] = [ RedirectKey(key=<DOWN>,clearmods=Control+Mod1),
		 RedirectKey(key=<DOWN>,clearmods=Control+Mod1,modifiers=Control),
		 RedirectKey(key=<DOWN>,clearmods=Control+Mod1,modifiers=Mod1),
		 NoAction() ]
	    };

	    replace key <RGHT> {
	      type = "CMD_OPT_HELD",
	      symbols[Group1] = [ Right, Right, Right, Right ],
	      actions[Group1] = [ RedirectKey(key=<RGHT>,clearmods=Control+Mod1),
		 RedirectKey(key=<RGHT>,clearmods=Control+Mod1,modifiers=Control),
		 RedirectKey(key=<RGHT>,clearmods=Control+Mod1,modifiers=Mod1),
		 NoAction() ]
	    };

	};
	xkb_geometry  { include "pc(pc105)"	};
};

```

Then to activate, use `xkbcomp $HOME/.xkb/custom $DISPLAY`. Notes:

- Doesn't work in .xsessionrc. Had to put in `~/.config/autostart/xkbcomp.desktop` containing:
```
[Desktop Entry]
Type=Application
Exec=/bin/bash -c 'sleep 3; xkbcomp $HOME/.xkb/custom $DISPLAY'
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Custom Keyboard Map
Name=Custom Keyboard Map
Comment[en_US]=
Comment=
```

- For some reason the original caused the Unity Dash to quit whenever I hit an arrow key. Resolved by redirecting the base key and clearing mods. Not sure why but glad it works.
- Set up two keyboard shortcuts in the Ubuntu GUI:

1. Switch to PC Modifiers - command `setxkbmap` - shortcut Super-Esc (physical Ctrl-Esc)
2. Switch to Mac Modifiers - command `xkbcomp $HOME/.xkb/custom $DISPLAY` - shortcut Ctrl-Esc (physical Ctrl-Esc when in PC Modifiers mode)
- Esc doesn't seem to be recognized. Need something else
