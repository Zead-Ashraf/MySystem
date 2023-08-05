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

function copy() {
    nav_to_file
    choosed_file=${choosed_file%.gpg}
    pass -c "$choosed_folder/$choosed_file"
}

function remove() {
    nav_to_file
    choosed_file=${choosed_file%.gpg}
    pass rm -f "$choosed_folder/$choosed_file"
}

function generate() {
    nav_to_folder
    password_name=$(echo -n -e "" | dmenu -l 3 -p "write password name:")
    pass generate -c "$choosed_folder/$password_name"
}

function main() {
    action=$(echo -n -e "copy\nremove\ngenerate" | dmenu -l 3 -p "choosed action:")
    if [[ $action == "copy" ]]; then
        copy
    elif [[ $action == "remove" ]]; then
        remove
    elif [[ $action == "generate" ]]; then
        generate
    else
        echo "you have choosed nothing"
    fi
}

main
