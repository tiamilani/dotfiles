#!/bin/zsh

dim=$(xdpyinfo | grep "dimensions" | awk '{ print $2 }')
ffmpeg -loglevel quiet -y -f x11grab -video_size $dim -i $DISPLAY -i ~/Pictures/Lock/lock1.png -filter_complex "boxblur=25:10,overlay=(main_w/2):(main_h/2-overlay_h/1.5)" -vframes 1  /tmp/lock_screen.png
i3lock -i /tmp/lock_screen.png &
