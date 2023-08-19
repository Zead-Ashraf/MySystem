#!/bin/bash

function get_track_name () {
    music_file_path=$(mocp -i | grep "File:" | cut -d"/" -f2-)

    path_cuted=true

    while $path_cuted; do
        music_track=$(echo $music_file_path | cut -d"/" -f2-)
        if [[ $(echo $music_track | grep -G "/" -o) != "" ]]; then
                music_track=$(echo $music_file_path | cut -d"/" -f2-)
                music_file_path=$music_track
        else
            path_cuted=false
        fi
    done
    option=$(echo -e "$music_track\nPlay Next\nPlay Previous" | dmenu -l 3 -p "Working Track:")
    case $option in
        "Play Next")
            $(mocp --next)
        ;;
        "Play Previous")
            $(mocp --previous)
        ;;
        *)
            echo "you have'nt execute any action"
    esac
}


function show_output() {
    is_playing=$(mocp -i | grep "State" | cut -d":" -f2- | cut -d" " -f2-)
    if [[ $is_playing == "PLAY" ]]; then
            get_track_name
    else
        echo "Sleeping" | dmenu -l 1 -p "Server Status:"
    fi
}

function main() {
    if [[ $(mocp -i) ]]; then 
            show_output
    else
        echo "Server Down" | dmenu -l 1 -p "Server Status:"
    fi
}

main
