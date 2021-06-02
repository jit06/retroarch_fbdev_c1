#/bin/bash

# build path for this build script
ODROIDC1_BUILD_PATH=/root/retroarch_fbdev_c1

echo ""
echo "============================================"
echo " change boot.ini                            "
echo "============================================"
sed -i -e 's/setenv m "480p"/setenv m "480cvbs" /g' /media/boot/boot.ini


echo ""
echo "============================================"
echo " set overscan                               "
echo "============================================"
echo "16 12 704 468" >> /media/boot/overscan

echo ""
echo "============================================"
echo " change uboot                               "
echo "============================================"
fw_setenv outputmode 480cvbs

