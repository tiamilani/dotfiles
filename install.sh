#!/bin/zsh

installEverything(){
	declare -a programs=("zsh" "feh")
	
	for program in ${programs[@]}; do
	   apt-get install $program
	done
}


linkFiles(){
	# create the dottedfiles directory
	cd $HOME
	mkdir dotfiles
	cd dotfiles
	
	declare -a directories=("feh" "i3" "images" "lockscript" "nerdfonts" "pathchecker"
							"polybar" "powerline" "rofi" "spotify_status" "vim" "zsh"
							)
	
	for dir in ${directories[@]}; do
		echo ${dir}
	done
}

# add user to video group to handle the backlight
#sudo vim /etc/udev/rules.d/backlight.rules
#add:
#ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
#ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
#
#$ sudo usermod -a -G video mattia

# List of programs to install
declare -a programs=("zsh" "feh")

while [ -n "$1" ]; do

	case "$1" in
		-i) INSTALL=true;;
		-l) LINK=true;;
		-t) TEST=true;;
		*) echo "error" && exit;;
	esac
	shift
done

if [ "${INSTALL}" = true ]; then
	installEverything
fi

if [ "${LINK}" = true ]; then
	linkFiles
fi

if [ "$TEST" = true ] ; then
	echo "cazzo"
fi
