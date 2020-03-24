#!/bin/bash

# remove cached pkg
apt-get clean

# clean up tmp files
rm /var/backups/*
rm -R /var/log/*

# clean root home
rm /root/.gitconfig
rm -Rf /root/.local
rm /resize.log
rm /boot/*
rm /root/.bash_history

cp aafirstboot .first_boot /

echo "File system has been prepared, poweroff and do not reboot"
