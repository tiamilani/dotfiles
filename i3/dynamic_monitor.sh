#!/bin/bash

#xrandr | grep "connected" && xrandr --output eDP-1-1 --auto --output DP-1-2-8 --primary --left-of eDP-1-1 --output DP-1-2-1 --left-of DP-1-2-8
# known configurations
declare -A conf
conf["19013dcb34f28d1a5da7f2e7371d3a30  -"]="/home/mattia/.screenlayout/home-TripleMonitor.sh"

# Get the list of currently connected monitors
signature=$(xrandr | rg -w "connected" | md5sum)

[ -v conf["${signature}"] ] && echo "${signature} key exists"
$(${conf["${signature}"]})
