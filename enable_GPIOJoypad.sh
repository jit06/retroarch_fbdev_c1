#/bin/bash

# build path for this build script
ODROIDC1_BUILD_PATH=/root/retroarch_fbdev_c1

echo ""
echo "============================================"
echo " install alsa utils for volume control      "
echo "============================================"
apt-get -y install alsa-utils


echo ""
echo "============================================"
echo " Compile and install WiringPi for odroid    "
echo "============================================"
cd /root
git clone --depth 1 https://github.com/hardkernel/wiringPi
cd wiringPi
./build

if [ ! -f /usr/local/lib/libwiringPi.so ]; then
    echo "======= failed installed WiringPi ======"
    echo ""
    exit 1
fi


echo ""
echo "============================================"
echo " checkout gpio joypad from git              "
echo "============================================"
cd /root
git clone --depth 1 https://github.com/jit06/gpio_joypad
cd gpio_joypad
gcc -o /usr/local/bin/gpio_joypad gpio_joypad.c -lwiringPi -lpthread -lm -lrt -lcrypt

if [ ! -f /usr/local/bin/gpio_joypad ]; then
    echo "===== failed installed gpio_joypad ===="
    echo ""
    exit 1
fi


echo ""
echo "============================================"
echo " install gpio-joypad service                "
echo "============================================"
cp $ODROIDC1_BUILD_PATH/systemd/gpio-joypad.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable gpio-joypad

cd $ODROIDC1_BUILD_PATH
