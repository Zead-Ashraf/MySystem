#!/bin/bash

function nav_to_folder() {
    prefix=${PASSWORD_STORE_DIR-~/.password-store}
    folders=$(ls $prefix)

    for folder in $folders; do
        options+="$folder\n"
    done

    choosed_folder=$(echo -n -e $options | dmenu -l 3 -p "choose Folder :")
}

function nav_to_file() {
    nav_to_folder

    passwords_files_path=( "$prefix/$choosed_folder" )

    passwords_files=$(ls $passwords_files_path)

    options="../\n"

    for password_file in $passwords_files; do
        options+="$password_file\n"
    done

    choosed_file=$(echo -n -e $options | dmenu -l 3 -p "choose File:")

    if [[ $choosed_file == "../" ]]; then
        options=""
        nav_to_file
    else
        return
    fi
}

function show() {
    nav_to_file
    choosed_file=${choosed_file%.gpg}
    pass -c "$choosed_folder/$choosed_file"
}

function remove() {
    nav_to_file
    choosed_file=${choosed_file%.gpg}
    pass rm -f "$choosed_folder/$choosed_file"
}

