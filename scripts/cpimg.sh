#!/bin/sh
PREREQ=""
prereqs() {
         echo "$PREREQ"
}

case $1 in 
# get pre-requisites 
prereqs)
         prereqs
         exit 0
         ;; esac

. /usr/share/initramfs-tools/hook-functions

cp -pnL /etc/splash.lzo ${DESTDIR}/etc
chmod 644 ${DESTDIR}/etc/splash.lzo

exit 0
