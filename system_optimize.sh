#!/bin/bash

function system_optimize() {

    # disable some unwanted services
    systemctl disable rsyslog
    systemctl disable ModemManager
    systemctl disable pppd-dns.service
    systemctl disable wpa_supplicant 
    systemctl disable loadcpufreq.service    

    # change boot.ini (change res, overclock, quiet boot, etc.)
    patch /media/boot/boot.ini $ODROIDC1_BUILD_PATH/patches/boot.ini.patch

    # journald in memory (instead of /var/log 
    sed -i "s/#Storage=auto/Storage=volatile/" /etc/systemd/journald.conf

    # journald output to serial instead of console 
    sed -i "s/#TTYPath=\/dev\/console/TTYPath=\/dev\/ttyS0/" /etc/systemd/journald.conf

    # /var/logs as tmpfs
    rm -Rf /var/log/*
    echo "tmpfs /var/log tmpfs nodev,nosuid,noatime,size=20M 0 0" >> /etc/fstab

    # optimize mount option for flash usage
    sed -i "s/ext4 defaults/ext4 noatime,discard,defaults/" /etc/fstab

}
