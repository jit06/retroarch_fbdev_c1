#!/bin/bash

function system_prepare() {

    # update / upgrade the base system
    apt-get update && apt-get -y upgrade apt-get -y dist-upgrade 
  
    # install needed packages
    apt-get -y install git mali-fbdev u-boot-tools busybox fbi
            
    # boot logo display
    cp $ODROIDC1_BUILD_PATH/splash.png /media/boot/
    cp $ODROIDC1_BUILD_PATH/boot-logo.bmp /media/boot/
    echo "/dev/mmcblk0 0x80000 0x8000" > /etc/fw_env.config
    fw_setenv preloadlogo 'video open;video clear; video dev open ${outputmode};fatload mmc 0:1 ${loadaddr_logo} boot-logo.bmp;bmp display ${loadaddr_logo}; bmp scale'

    # default to 720x480 in uboot
    fw_setenv hdmimode 480p60hz
    fw_setenv outputmode 480p
    fw_setenv fb_width=720
    fw_setenv fb_height=480


    # allow overscan management throught overscan file in /media/boot
    sed -i '/exit 0/d' /etc/rc.local
    echo '
    if [ -f /media/boot/overscan ]; then
        overscan=$(cat /media/boot/overscan)
        echo $overscan > /sys/class/graphics/fb0/window_axis
        echo 0x10001 > /sys/class/graphics/fb0/free_scale
    fi
    exit 0
    ' >> /etc/rc.local

    
    # add cursor to console for all users
    echo "
    # cursor in console
    if [ ! -f ~/.terminfo.txt ]; then
        infocmp >> ~/.terminfo.txt
        sed -i -e 's/?0c/?112c/g' -e 's/?8c/?48;0;64c/g' ~/.terminfo.txt
    fi

    tic ~/.terminfo.txt > /dev/null
    tput cnorm" >> /etc/profile

    
    # quiet login
    # systemctl disable getty@tty1.service
    touch /root/.hushlogin
}

