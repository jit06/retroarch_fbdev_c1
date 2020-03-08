#!/bin/bash

function retroarch_install() {

    # get Retropie-Setup which is the base to build retroarch
    cd /root
    git clone --depth 1 https://github.com/RetroPie/RetroPie-Setup


    # apply some custom patches for Odroid c1 to make compilation works
    patch $RETROPIE_SETUP_PATH/scriptmodules/libretrocores/lr-flycast.sh $ODROIDC1_BUILD_PATH/patches/lr-flycast.patch
    patch $RETROPIE_SETUP_PATH/scriptmodules/emulators/amiberry.sh $ODROIDC1_BUILD_PATH/patches/amiberry.patch


    # Build Retroarch / Retropie packages
    for package in $PACKAGES
    do
        $RETROPIE_SETUP_PATH/retropie_packages.sh package
    done


    # make symlink for libretro cores so retroarch find them for gamelists creation
    cd /opt/retropie/libretrocores/
    find . -type f -name *.so -exec ln -s {} \;


    # make amiberry launcher
    cd /root
    git clone https://github.com/jit06/libretro-amiberry-launcher
    cd libretro-amiberry-launcher
    make
    cp amiberry_launcher_libretro.so /opt/retropie/libretrocores/


    # copy systemd service to start retroarch at boot
    cp $ODROIDC1_BUILD_PATH/systemd/retroach.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable retroarch
}
