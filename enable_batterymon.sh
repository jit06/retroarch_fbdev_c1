#/bin/bash

# build path for this build script
ODROIDC1_BUILD_PATH=/root/retroarch_fbdev_c1

echo ""
echo "============================================"
echo " check for retroarch installed assets       "
echo "============================================"

if [ ! -d /root/.config/retroarch/assets/xmb/retroactive/png ]; then
    echo "Retroarch asset must have been downloaded before launching this script !"
    echo ""
    exit 0
fi


echo ""
echo "============================================"
echo " install kernel with battery support        "
echo "============================================"
cd /root 
wget https://github.com/jit06/linux/releases/download/V2.1/linux-odroic-noconsole-battery.tar.gz
tar -zxf linux-odroic-noconsole-battery.tar.gz
cd linux-odroic-noconsole-battery
cp uImage /media/boot
cp -R lib/* /lib/


echo ""
echo "============================================"
echo " install custom battery icons               "
echo "============================================"
cp $ODROIDC1_BUILD_PATH/skin/Retroarch/Battery_icons/* /root/.config/retroarch/assets/xmb/retrosystem/png/


echo ""
echo "============================================"
echo " install odroid-battery service             "
echo "============================================"
cp $ODROIDC1_BUILD_PATH/scripts/odroid_battery.sh /opt/
cp $ODROIDC1_BUILD_PATH/systemd/odroid-battery.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable odroid-battery

cd $ODROIDC1_BUILD_PATH
