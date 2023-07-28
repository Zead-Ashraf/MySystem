#!/bin/bash

mounted_devices=$(mount -l | grep "^/dev/" | grep "^\S*" -o)

exclude_string=""

for mounted_device in $mounted_devices; do
    exclude_string+="$mounted_device|"
done

exclude_string+="cdrom"

devices=$(sudo blkid -o device | grep -v -E ${exclude_string})

options_list=""

for device in $devices; do
    options_list+="$device\n"
done

mount_device=$(echo -e -n $options_list | dmenu -l 3 -p "choose device:")

if [[ $mount_device ]]; then
    device_label=$(sudo blkid -o export -s LABEL | grep $mount_device -A 1 | grep "^LABEL=" | cut -d"=" -f2-)
    mount_path="/media/$device_label"
    mkdir $mount_path
    sudo mount -t auto $mount_device $mount_path
else
    echo "you have not choosed nothing"
fi