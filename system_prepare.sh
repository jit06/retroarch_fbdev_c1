#!/bin/bash

function system_prepare() {

    # update / upgrade the base system
    apt-get update && apt-get upgrade apt-get dist-upgrade 

    
    # install needed packages
    apt-get install git mali-fbdev
    

    # disable some unwanted services
    systemctl disable rsyslog
    systemctl disable ModemManager
    systemctl disable pppd-dns.service
    systemctl disable wpa_supplicant 
    systemctl disable loadcpufreq.service

    
    # allow overscan management
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
     touch /root/.hushlogin
}

