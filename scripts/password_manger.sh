#!/bin/bash

function nav_to_main_folder() {
    prefix=${PASSWORD_STORE_DIR-~/.password-store}
    folders=$(ls $prefix)

    for folder in $folders; do
        options+="$folder\n"
    done

    choosed_folder=$(echo -n -e $options | dmenu -l 3 -p "choose Folder :")
}

function get_other_infos() {
    prefix="$passwords_files_path/$1"
    infos=$(ls $prefix)
    
    options="../\n"
    for info in $infos; do
        options+="$info\n"
    done

    choosed_info=$(echo -n -e $options | dmenu -l 3 -p "choose option:")
}

function nav_to_file() {
    nav_to_main_folder
    prefix_choosed_folder=$choosed_folder
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
    elif [[ -d "$passwords_files_path/$choosed_file" ]]; then
         get_other_infos $choosed_file
         if [[ $choosed_info == "../" ]]; then
             options=""
            nav_to_file
         else
            choosed_folder="$prefix_choosed_folder/$choosed_file"
            choosed_file="$choosed_info"
            return
         fi
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
    nav_to_main_folder
    password_name=$(echo -n -e "" | dmenu -l 3 -p "write password name:")
    if [[ -n $password_name ]]; then    
        pass generate -c "$choosed_folder/$password_name"
    else
       echo "you have choosed nothing" 
    fi
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
