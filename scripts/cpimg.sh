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
# fbcp 
. /usr/share/initramfs-tools/hook-functions
rm -f ${DESTDIR}/etc/splash.lzo
cp /root/retroarch_fbdev_c1/splash.lzo ${DESTDIR}/etc
chmod 666 ${DESTDIR}/etc/splash.lzo
exit 0
