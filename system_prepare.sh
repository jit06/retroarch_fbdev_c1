#!/bin/bash

function system_prepare() {

    # update / upgrade the base system
    echo ""
    echo "============================================"
    echo " starting to upgrade the system...          "
    echo "============================================"
    apt-get update
    apt-get -y upgrade 

    # install needed packages
    echo ""
    echo "============================================"
    echo " install needed packages...                 "
    echo "============================================"
    apt-get -y install busybox fbi xsltproc mplayer


    # boot logo display
    echo ""
    echo "============================================"
    echo " setting up boot logo...                    "
    echo "============================================"
    cp $ODROIDC1_BUILD_PATH/skin/Splash/boot-logo.bmp /media/boot/
    fw_setenv preloadlogo 'video open;video clear; video dev open ${outputmode};fatload mmc 0:1 ${loadaddr_logo} boot-logo.bmp;bmp display ${loadaddr_logo}; bmp scale'
    

    # default to 640x480 in uboot
    echo ""
    echo "============================================"
    echo " set default resolution to 480p in uboot... "
    echo "============================================"
    fw_setenv hdmimode 480p
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


    # mplayer stuff for video preview
    echo ""
    echo "============================================"
    echo " setting up mplayer for video preview...    "
    echo "============================================"
    mkdir /root/.mplayer
    mkfifo /root/.mplayer/fifo
    cp $ODROIDC1_BUILD_PATH/scripts/video_*.sh /opt
    
    
    # change boot.ini (change res, overclock, quiet boot, etc.)
    echo ""
    echo "============================================"
    echo " custom boot.ini...                          "
    echo "============================================"
    cp $ODROIDC1_BUILD_PATH/configs/boot.ini /media/boot/
}

