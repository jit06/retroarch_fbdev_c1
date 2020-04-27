#!/bin/bash

# remove cached pkg
apt-get clean

# set hostname
echo "gamodroid" > /etc/hostname

# clean up tmp files
rm /var/backups/*
rm -R /var/log/*

# clean root home
rm /root/.gitconfig
rm -Rf /root/.local
rm /resize.log
rm /boot/*
rm /root/.bash_history
rm /root/retroarch_fbdev_c1/buildlogs/*
rm /root/.config/retroarch/playlists/*

cp aafirstboot .first_boot /

echo "File system has been prepared, poweroff and do not reboot"
