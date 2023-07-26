#!/bin/bash

wallpapers=(`ls ~/wallpapers`)
wallpapersLength=${#wallpapers[@]}
randomNumber=$(($RANDOM % $wallpapersLength + 0))

feh --no-fehbg --bg-fill "/home/i7oras/wallpapers/${wallpapers[$randomNumber]}"
