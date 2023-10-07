#!/bin/bash

if [[ $1 == "0" ]]; then
    action="0"
else
    echo "What do you want to do:"
    echo "0) encrypt"
    echo "1) decrypt"
    read action
fi

if [[ $action == "0" ]]; then 
    {
        files=(`ls <PATH>`)
    } && {
        for file in $files; do
            if [[ $file == "system.sh" ]]; then
                continue
            else
                echo "$file"
                {
                    gpg --encrypt --output "$file.gpg" --recipient <RECIPIENT> $file
                } && {
                    rm $file
                } || {
                    echo "Faild to encrypt"
                }
            fi
        done
    } || {
        echo "There is nothing to encrypt"
    }
    elif [[ $action == "1" ]]; then
        echo "decrypt"
        index="0"
        declare -a files_arr
        {
            files=$(ls <PATH>.gpg)
        } && {
            for file in $files; do
                if [[ $file == "system.sh" ]]; then
                    continue
                else
                    fileIndexName=$(echo $file | cut -d'/' -f<I>-)
                    fileIndex="$index-$fileIndexName"
                    index=$(( $index + 1  ))
                    files_arr+=( $file  )
                    echo $fileIndex
                fi
            done
            echo "What do you want to read ?"
            read choosedFile
            file=${files_arr[choosedFile]}
            { 
                gpg --decrypt $file | vi -
            } || {
                    echo "Faild to decrypt"
                }
        }
    else
        echo "wrong way blues"
fi
