#!/bin/bash

devices=$(sudo blkid -o device | grep -v -e "/dev/sdb4" -e "/dev/sdb2" -e "/dev/sdb3" -e "/dev/sdb1" -e "/dev/sda4" -e "/dev/sda2" -e "/dev/sda3") # "/dev/sda1"

options_list=""

for device in $devices; do
    options_list+="$device\n"
done

mount_device=$(echo -e -n $options_list | dmenu -l 3 -p "choose device:")

#device_UUID=$(sudo blkid -o export -s UUID | grep $mount_device -A 1 | grep "^UUID=" | cut -d"=" -f2-)
#echo $device_UUID

device_label=$(sudo blkid -o export -s LABEL | grep $mount_device -A 1 | grep "^LABEL=" | cut -d"=" -f2-)

mount_path="/media/$device_label"

mkdir $mount_path
sudo mount -t auto $mount_device $mount_path

