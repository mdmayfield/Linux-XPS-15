# Keyboard Shortcuts

System-level file changes in `/usr/share/X11/xkb/`:

1. types/mm-arrow-swap
```
partial default xkb_types "default" {

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
```
2. types/complete
```
default xkb_types "complete" {
    include "basic"
    include "mousekeys"
    include "pc"
    include "iso9995"
    include "level5"
    include "extra"
    include "numpad"
    include "mm-arrow-swap"
};
```
- Note last line was added.
3. symbols/pc
```
default  partial alphanumeric_keys modifier_keys
xkb_symbols "pc105" {

    key <ESC>  {	[ Escape		]	};

    // The extra key on many European keyboards:
    key <LSGT> {	[ less, greater, bar, brokenbar ] };

    // The following keys are common to all layouts.
    key <BKSL> {	[ backslash,	bar	]	};
    key <SPCE> {	[ 	 space		]	};

    include "srvr_ctrl(fkey2vt)"
    include "pc(editing)"
    include "keypad(x11)"

//    key <BKSP> {	[ BackSpace, BackSpace	]	};
    key <BKSP> {
      type = "CMD_OPT_HELD",
      symbols[Group1] = [ BackSpace, BackSpace, BackSpace, BackSpace ],
      actions[Group1] = [ NoAction(),
         RedirectKey(key=<BKSP>,clearmods=Control+Mod1,modifiers=Control),
         RedirectKey(key=<BKSP>,clearmods=Control+Mod1,modifiers=Mod1),
         NoAction() ]
    };

    key  <TAB> {	[ Tab,	ISO_Left_Tab	]	};
    key <RTRN> {	[ Return		]	};

    key <CAPS> {	[ Caps_Lock		]	};
    key <NMLK> {	[ Num_Lock 		]	};

    key <LFSH> {	[ Shift_L		]	};
    key <LCTL> {	[ Control_L		]	};
    key <LWIN> {	[ Super_L		]	};

    key <RTSH> {	[ Shift_R		]	};
    key <RCTL> {	[ Control_R		]	};
    key <RWIN> {	[ Super_R		]	};
    key <MENU> {	[ Menu			]	};

    // Beginning of modifier mappings.
    modifier_map Shift  { Shift_L, Shift_R };
    modifier_map Lock   { Caps_Lock };
    modifier_map Control{ Control_L, Control_R };
    modifier_map Mod2   { Num_Lock };
    modifier_map Mod4   { Super_L, Super_R };

    // Fake keys for virtual<->real modifiers mapping:
    key <LVL3> {	[ ISO_Level3_Shift	]	};
    key <MDSW> {	[ Mode_switch 		]	};
    modifier_map Mod5   { <LVL3>, <MDSW> };

    key <ALT>  {	[ NoSymbol, Alt_L	]	};
    include "altwin(meta_alt)"

    key <META> {	[ NoSymbol, Meta_L	]	};
    modifier_map Mod1   { <META> };

    key <SUPR> {	[ NoSymbol, Super_L	]	};
    modifier_map Mod4   { <SUPR> };

    key <HYPR> {	[ NoSymbol, Hyper_L	]	};
    modifier_map Mod4   { <HYPR> };
    // End of modifier mappings.

    // MM custom modifiers for XPS 15
    replace key <LALT> { [ Control_L, Control_L ] };
    replace key <LWIN> { [ Alt_L, Meta_L ] };
    replace key <LCTL> { [ Super_L ] };
    replace key <RALT> { [ Control_R, Control_R ] };
    replace key <RCTL> { [ Alt_R ] };
    // MM custom modifiers for generic PC keyboard
//    replace key <LALT> { [ Control_L, Control_L ] };
//    replace key <LWIN> { [ Alt_L, Meta_L ] };
//    replace key <LCTL> { [ Super_L ] };
//    replace key <RALT> { [ Control_R, Control_R ] };
//    replace key <RWIN> { [ Alt_R, Meta_R ] };
//    replace key <RCTL> { [ Super_R ] };
    // End custom modifiers

    key <OUTP> { [ XF86Display ] };
    key <KITG> { [ XF86KbdLightOnOff ] };
    key <KIDN> { [ XF86KbdBrightnessDown ] };
    key <KIUP> { [ XF86KbdBrightnessUp ] };

};

hidden partial alphanumeric_keys
xkb_symbols "editing" {
    key <PRSC> {
	type= "PC_ALT_LEVEL2",
	symbols[Group1]= [ Print, Sys_Req ]
    };
    key <SCLK> {	[  Scroll_Lock		]	};
    key <PAUS> {
	type= "PC_CONTROL_LEVEL2",
	symbols[Group1]= [ Pause, Break ]
    };
    key  <INS> {	[  Insert		]	};
    key <HOME> {	[  Home			]	};
    key <PGUP> {	[  Prior		]	};
    key <DELE> {	[  Delete		]	};
    key  <END> {	[  End			]	};
    key <PGDN> {	[  Next			]	};

//    key   <UP> {	[  Up			]	};
    key <UP> {
      type = "CMD_OPT_HELD",
      symbols[Group1] = [ Up, Up, Up, Up ],
      actions[Group1] = [ NoAction(),
         RedirectKey(key=<UP>,clearmods=Control+Mod1,modifiers=Control),
         RedirectKey(key=<UP>,clearmods=Control+Mod1,modifiers=Mod1),
         NoAction() ]
    };

//    key <LEFT> {	[  Left			]	};
    key <LEFT> {
      type[Group1] = "CMD_OPT_HELD",
      symbols[Group1] = [ Left, Left, Left, Left ],
      actions[Group1] = [ NoAction(),
         RedirectKey(key=<LEFT>,clearmods=Control+Mod1,modifiers=Control),
         RedirectKey(key=<LEFT>,clearmods=Control+Mod1,modifiers=Mod1),
         NoAction() ]
    };

//    key <DOWN> {	[  Down 	 	]	};
    key <DOWN> {
      type = "CMD_OPT_HELD",
      symbols[Group1] = [ Down, Down, Down, Down ],
      actions[Group1] = [ NoAction(),
         RedirectKey(key=<DOWN>,clearmods=Control+Mod1,modifiers=Control),
         RedirectKey(key=<DOWN>,clearmods=Control+Mod1,modifiers=Mod1),
         NoAction() ]
    };

//    key <RGHT> {	[  Right		]	};
    key <RGHT> {
      type = "CMD_OPT_HELD",
      symbols[Group1] = [ Right, Right, Right, Right ],
      actions[Group1] = [ NoAction(),
         RedirectKey(key=<RGHT>,clearmods=Control+Mod1,modifiers=Control),
         RedirectKey(key=<RGHT>,clearmods=Control+Mod1,modifiers=Mod1),
         NoAction() ]
    };

};
```

This performs the following:

- Physical LAlt/RAlt become logical LCtl/RCtl
- Physical LWin/RCtl become logical LAlt/RAlt
- Physical LCtl becomes logical Super
- (Shift)-Ctrl-Arrows become (Shift)-Alt-Arrows
- (Shift)-Alt-Arrows become (Shift)-Ctrl-Arrows

It has the side effect that autorepeat is disabled on the arrow keys. To circumvent this, add to .xsessionrc:

```
# Re-enable repeats disabled by redirect actions
xset r 113 #Left
xset r 114 #Right
xset r 111 #Up
xset r 116 #Down
xset r 22  #Backspace
```

Attempts to do this at the user level had disadvantages:
- The Unity Dash disappeared when pressing arrow keys, until suspend/resume
- Switching to a different TTY and back (Ctrl-Alt-F1/F7 for example) knocked out the user keymap

## OS Keyboard Shortcut changes
- Set Ctrl-Tab and Ctrl-\` for application switching

## AutoKey
AutoKey has the useful behavior that, for the redirected arrow keys, it listens for the original unaltered modifiers, not xkb's remaps, so we can use it to finish the Mac-like shortcut experience.

----

# Update 2017-10-16

A large part of this (not the arrow key and backspace modifier swaps yet) can be done OOTB with:
```
setxkbmap -option ctrl:swap_lalt_lctl_lwin
setxkbmap -option ctrl:ralt_rctrl
setxkbmap -option ctrl:rctrl_ralt
```
