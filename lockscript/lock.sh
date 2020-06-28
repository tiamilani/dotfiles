#!/bin/zsh

dim=$(xdpyinfo | grep "dimensions" | awk '{ print $2 }')
ffmpeg -loglevel quiet -y -f x11grab -video_size $dim -i $DISPLAY -i ~/Pictures/Lock/lock1.png -filter_complex "boxblur=7:1,overlay=(main_w-3*main_w/4):(main_h-overlay_h)" -vframes 1  /tmp/lock_screen.png 
i3lock -i /tmp/lock_screen.png
