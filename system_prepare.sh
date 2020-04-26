#!/bin/bash

function system_prepare() {

    # update / upgrade the base system
    echo ""
    echo "============================================"
    echo " starting to upgrade the system...          "
    echo "============================================"
    apt-get update
    apt-get -y upgrade 
    apt-get -y dist-upgrade 

    # install needed packages
    echo ""
    echo "============================================"
    echo " install needed packages...                 "
    echo "============================================"
    apt-get -y install git mali-fbdev u-boot-tools busybox fbi gcc-8 g++-8 xsltproc mplayer

    # set gcc version default to 8 else lr-flycast does not compile correctly
    update-alternatives --set gcc "/usr/bin/gcc-8"
    update-alternatives --set g++ "/usr/bin/g++-8"

    # some app may not compile without thoses links (eg. lr-muppen64plus)
    ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so /usr/lib/libEGL.so
    ln -s /usr/lib/arm-linux-gnueabihf/libGLESv2.so /usr/lib/libGLES.so

    # boot logo display
    echo ""
    echo "============================================"
    echo " setting up boot logo...                    "
    echo "============================================"
    cp $ODROIDC1_BUILD_PATH/skin/Splash/boot-logo.bmp /media/boot/
    echo "/dev/mmcblk0 0x80000 0x8000" > /etc/fw_env.config
    fw_setenv preloadlogo 'video open;video clear; video dev open ${outputmode};fatload mmc 0:1 ${loadaddr_logo} boot-logo.bmp;bmp display ${loadaddr_logo}; bmp scale'

    # default to 720x480 in uboot
    echo ""
    echo "============================================"
    echo " set default resolution to 480p in uboot... "
    echo "============================================"
    fw_setenv hdmimode 480p60hz
    fw_setenv outputmode 480p
    fw_setenv fb_width 640
    fw_setenv fb_height 480
    fw_setenv display_width 640
    fw_setenv display_height 480


    # allow overscan, brightness and contrast management throught files in /media/boot
    echo ""
    echo "============================================"
    echo " setting up display management...           "
    echo "============================================"
    sed -i '/exit 0/d' /etc/rc.local
    echo '
    if [ -f /media/boot/overscan ]; then
        overscan=$(cat /media/boot/overscan)
        echo $overscan > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    fi
    if [ -f /media/boot/contrast ]; then
        contrast=$(cat /media/boot/contrast)
        echo $contrast > /sys/class/video/vpp_contrast
    fi
    if [ -f /media/boot/brightness ]; then
        brightness=$(cat /media/boot/brightness)
        echo $brightness > /sys/class/video/vpp_brightness
    fi
    if [ -e /dev/mmcblk1p1 ]; then
        mount /dev/mmcblk1p1 /root/RetroPie
    fi
    exit 0
    ' >> /etc/rc.local


    # add cursor to console for all users
    echo ""
    echo "============================================"
    echo " setting up cursor in console...            "
    echo "============================================"
    echo "
    # cursor in console
    if [ ! -f ~/.terminfo.txt ]; then
        infocmp >> ~/.terminfo.txt
        sed -i -e 's/?0c/?112c/g' -e 's/?8c/?48;0;64c/g' ~/.terminfo.txt
    fi

    tic ~/.terminfo.txt > /dev/null
    tput cnorm" >> /etc/profile

    # mplayer stuff for video preview
    echo ""
    echo "============================================"
    echo " setting up mplayer for video preview...    "
    echo "============================================"
    mkfifo /root/.mplayer/fifo
    cp $ODROIDC1_BUILD_PATH/scripts/video_*.sh /opt

    # quiet login
    echo ""
    echo "============================================"
    echo " quiet login and boot...	              "
    echo "============================================"
    systemctl disable getty@tty1.service
    touch /root/.hushlogin
}

