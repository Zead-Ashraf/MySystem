#!/bin/bash

#mounted_devices=$(ls "/media/" | grep "mtp")
function mount_mtp() {
    devices_index=$(ls "/media/" | grep "^mtp_" | cut -d"_" -f2- | tail -n 1)

    if [[ $devices_index ]]; then
        next_index=$(($devices_index + 1))
    else
        next_index=1
    fi

    mount_device=$(echo -e -n "mtp_$next_index" | dmenu -l 4 -p "mount MTP:")

    if [[ $mount_device ]]; then
        mkdir "/media/mtp_$next_index"
        jmtpfs "/media/mtp_$next_index"
    else
        echo "you have not choosed nothing"
    fi
}

export mount_mtp
