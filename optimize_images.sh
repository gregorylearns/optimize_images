#!/bin/bash


function optimize_images {
	find . -type f -iname "*.png" -exec pngquant --force --ext .png --skip-if-larger {} \;
	find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -exec jpegoptim -q -f --strip-all {} \;
}

function start_spinner {
    set +m
    echo -n "$1         "
    { while : ; do for X in '  •     ' '   •    ' '    •   ' '     •  ' '      • ' '     •  ' '    •   ' '   •    ' '  •     ' ' •      ' ; do echo -en "\b\b\b\b\b\b\b\b$X" ; sleep 0.1 ; done ; done & } 2>/dev/null
    spinner_pid=$!
}

function stop_spinner {
    { kill -9 $spinner_pid && wait; } 2>/dev/null
    set -m
    echo -en "\033[2K\r"
}


while true; do

echo "Do you want to optimize images in this directory (recursive)?"
read -p "NOTE: this will overwrite original images (y/n)\n " yn

case $yn in 
	[yY] ) echo ok, we will proceed;
		start_spinner
		optimize_images
		stop_spinner
		break;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;;
esac

done

