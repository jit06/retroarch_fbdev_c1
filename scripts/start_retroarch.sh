#/bin/bash

exec 3<> /root/.mplayer/fifo
echo 1 > /sys/class/graphics/fb1/blank

outputmode=`fw_printenv | grep outputmode=` 
if [ "$outputmode" = "outputmode=480p" ]; then
	fbset -fb /dev/fb1 -g 400 300 400 300 32
elif [ "$outputmode" = "outputmode=480cvbs" ]; then
	fbset -fb /dev/fb1 -g 400 150 400 150 32
fi

/opt/retropie/emulators/retroarch/bin/retroarch
/sbin/poweroff
