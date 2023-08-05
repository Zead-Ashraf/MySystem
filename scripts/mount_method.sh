#!/bin/bash

method=$(echo -e -n "Flash Drive\nMTP Device" | dmenu -l 2 -p "Choose method :")

current_dir="$(dirname "$0")"

if [[ $method == "Flash Drive" ]]; then 
    action=$(echo -e -n "Mount\nUnmount" | dmenu -l 2 -p "Choose action:")
    if [[ $action == "Mount" ]]; then
        source $current_dir/mount_source/mount_usb_drive.sh
        mount_flash
        elif [[ $action == "Unmount" ]]; then
            source $current_dir/mount_source/unmount_usb_drive.sh
            unmount_flash
    else
        echo "you must choose action"
    fi

    elif [[ $method == "MTP Device" ]]; then
        action=$(echo -e -n "Mount\nUnmount" | dmenu -l 2 -p "Choose action:")
        if [[ $action == "Mount" ]]; then
                source $current_dir/mount_source/mount_mtp.sh
                mount_mtp
            elif [[ $action == "Unmount" ]]; then
                source $current_dir/mount_source/unmount_mtp.sh
                unmount_mtp
        else
            echo "you must choose action"
        fi
else
    echo "You have choosed nothing"
fi
