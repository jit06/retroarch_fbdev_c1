#!/bin/bash

function system_splash() {

	# set initramfs script for splash screen
	cp $ODROIDC1_BUILD_PATH/scripts/splash /etc/initramfs-tools/scripts/local-bottom/
	chmod 755 /etc/initramfs-tools/scripts/init-top/splash

	cp $ODROIDC1_BUILD_PATH/scripts/cpimg.sh /etc/initramfs-tools/hooks/
	chmod 755 /etc/initramfs-tools/hooks/cpimg.sh


	# Generate new uInitrd
	cp /media/boot/uInitrd /media/boot/uInitrd.bak
	update-initramfs -u
	mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d /boot/initrd.img-3.10.107-13 /media/boot/uInitrd

}
