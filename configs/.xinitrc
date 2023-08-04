#!/bin/sh

# change background using (feh)
~/.fehbg

# set langauge layout
setxkbmap -option grp:ctrl_shift_toggle us,ar

xcompmgr & exec dwm & exec slstatus & sxhkd -c ~/.config/sxhkd/sxhkdrc
