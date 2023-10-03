#!/bin/bash

function poweroff_sync() {
    {
        bash ~/scripts/sync.sh
    } && {
        $(systemctl poweroff)
    } || {
        callback=$(echo -e -n "Force Poweroff \nRetry \nExit " | dmenu -l 3 -fn "Font Awesome" -p "Faild to sync:")
        case $callback in
            "Force Poweroff ")
                $(systemctl poweroff)
            ;;
            "Retry ")
                terminator -x bash ~/scripts/control_power.sh
            ;;
            "Exit ")
                exit
            ;;
        esac
    }
}

option=$(echo -e -n "Poweroff & Sync \nPoweroff \nReboot \nLock " | dmenu -l 4 -fn "Font Awesome" -p "Control Power:")

case $option in 
    "Poweroff ")
        $(systemctl poweroff)
        ;;
    "Poweroff & Sync ")
        poweroff_sync
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
