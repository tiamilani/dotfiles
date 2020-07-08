#!/bin/zsh

killall feh

_screen() {
	feh --bg-scale -g "$1" "$2"
}

for i in $( xrandr -q | grep ' connected' | grep -oP '\d+x\d+\+\d+\+\d+')
do
    _screen "$i" "$HOME/Pictures/Sfondi/strada.jpg"
done
