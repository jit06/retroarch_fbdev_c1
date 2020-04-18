#/bin/bash

echo "This script assume that retroarch_fbdev_c1 repository exists in /root"
echo "Retroarch is goind to be stopped..."
echo ""
sleep 3

# stop retroarch
systemctl stop retroarch

# install needed package
apt-get -y install busybox fbi

echo ""
echo "dependencies ok, now display image and dump framebuffer"

# display image on fbdev
fbi -T 1 -d /dev/fb0 -a -noverbose /root/retroarch_fbdev_c1/skin/Splash/splash.png
fbi_pid=$(pidof fbi)

# dump fbdev and compress it
cp /dev/fb0 /root/retroarch_fbdev_c1/splash
kill $fbi_pid

echo ""
echo "Framebuffer grabbed, now generating lzo file"
rm /root/retroarch_fbdev_c1/splash.lzo
busybox lzop -6 /root/retroarch_fbdev_c1/splash
rm /root/retroarch_fbdev_c1/splash

echo ""
if [ -f /root/retroarch_fbdev_c1/splash.lzo ]; then
	echo "done !"
else
	echo "ERROR : lzo file not generated"
fi
echo ""
