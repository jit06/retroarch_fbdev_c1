#!/bin/bash

function system_splash() {
    echo ""
    echo "============================================"
    echo " Install splash screen...	                  "
    echo "============================================"
	
    # set initramfs script for splash screen 
    cp $ODROIDC1_BUILD_PATH/skin/Splash/splash.lzo /etc/
    cp $ODROIDC1_BUILD_PATH/scripts/cpimg.sh /etc/initramfs-tools/hooks/
    cp $ODROIDC1_BUILD_PATH/scripts/c1_init.sh /etc/initramfs-tools/scripts/local-top/
    chmod +x /etc/initramfs-tools/hooks/cpimg.sh
    chmod +x /etc/initramfs-tools/scripts/local-top/c1_init.sh
    
    # Generate new uInitrd
    update-initramfs -u
    mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d /boot/initrd.img-3.10.107-13 /media/boot/uInitrd
}
