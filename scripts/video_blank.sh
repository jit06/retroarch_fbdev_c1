#/bin/bash
dd if=/dev/zero of=/dev/fb1
echo $1 > /sys/class/graphics/fb1/blank
