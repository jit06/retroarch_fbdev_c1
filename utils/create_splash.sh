#/bin/bash

echo "This script assume that retroarch_fbdev_c1 repository exists in /root"
sleep 3

# install needed package
apt-get -y install busybox fbi

# display image on fbdev
fbi -T 1 -d /dev/fb0 -a -noverbose /root/retroarch_fbdev_c1/splash.png
fbi_pid=$!

# dump fbdev and compress it
cp /dev/fb0 /root/retroarch_fbdev_c1/splash
kill $fbi_pid
busybox lzop -6 /root/retroarch_fbdev_c1/splash
