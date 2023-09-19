#!/bin/sh

# change background using (feh)
~/.fehbg

# set langauge layout
setxkbmap -layout us,ara -option grp:win_space_toggle
setxkbmap -option caps:escape

xcompmgr & exec dwm & exec slstatus & sxhkd -c ~/.config/sxhkd/sxhkdrc
