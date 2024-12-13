#!/bin/zsh

killall feh

_screen() {
	feh --bg-scale -g "$1" "$2"
}


for i in $( xrandr -q | grep ' connected' | grep -oP '\d+x\d+\+\d+\+\d+')
do
	#next_wallpaper=$(shuf ~/Pictures/Wallpaper/* -e -n 1)
	next_wallpaper="/home/mattia/Pictures/Wallpaper/glider.png"
    _screen "$i" ${next_wallpaper}
done
