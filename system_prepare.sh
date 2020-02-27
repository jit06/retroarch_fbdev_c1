#!/bin/bash

function system_prepare() {

    # update / upgrade the base system
    apt-get update && apt-get upgrade apt-get dist-upgrade 

    # install needed packages


    # disable some unwanted services
    systemctl disable rsyslog
    systemctl disable ModemManager
    systemctl disable pppd-dns.service
    systemctl disable wpa_supplicant 
    systemctl disable loadcpufreq.service


    # add cursor to console for all users
    echo "
    # cursor in console
    if [ ! -f ~/.terminfo.txt ]; then
        infocmp >> ~/.terminfo.txt
        sed -i -e 's/?0c/?112c/g' -e 's/?8c/?48;0;64c/g' ~/.terminfo.txt
    fi

    tic ~/.terminfo.txt > /dev/null
    tput cnorm" >> /etc/profile

}

