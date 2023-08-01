#!/bin/bash
function unmount_mtp() {
    mounted_devices=$(ls "/media/" | grep "mtp")

    options_list=""

    for device in $mounted_devices; do 
        options_list+="$device\n"
    done

    unmount_device=$(echo -e -n $options_list | dmenu -l 3 -p "choose device:")

    if [[ $unmount_device ]]; then
        sudo umount -l "/media/$unmount_device"
        rm -rf "/media/$unmount_device"
    else
        echo "you have not choosed nothing"
    fi
}

export unmount_mtp 
