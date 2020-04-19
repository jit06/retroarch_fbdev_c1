#/bin/bash
dd if=/dev/zero of=/dev/fb1 bs=1M count=1
echo $1 > /sys/class/graphics/fb1/blank
