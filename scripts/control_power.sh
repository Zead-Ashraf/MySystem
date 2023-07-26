#!/bin/bash

option=$(echo -e -n "Poweroff \nReboot \nLock " | dmenu -l 3 -p "Control Power:")

case $option in 
    "Poweroff ")
        $(systemctl poweroff)
        ;;
    "Reboot ")
        $(systemctl reboot)
        ;;
    "Lock ")
        $(i3lock -c '0d1926' --clock --time-str '%I:%M%p' --date-str '%a %d %B %Y' --date-color '0883ff' --time-color 'ff0883' --date-size 20 --time-size 32)
        ;;
    *)
        echo "something is wrong"
        ;;
esac
