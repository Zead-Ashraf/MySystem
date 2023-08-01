#!/bin/bash
function unmount_flash() {
    mounted_devices=$(ls /media/)

    options_list=""

    for device in $mounted_devices; do
        options_list+="$device\n"
    done

    umount_device=$(echo -e -n $options_list | dmenu -l 3 -p "choose device:")

    if [[ $umount_device ]]; then
        sudo umount "/media/$umount_device"
        rm -rf "/media/$umount_device"
    else
        echo "you have not choosed nothing"
    fi
}

export unmount_flash
