#!/bin/bash

function retroarch_install() {

    echo ""
    echo "============================================"
    echo " clone retropie repo...                     "
    echo "============================================"
    # get Retropie-Setup which is the base to build retroarch
    cd /root
    git clone --depth 1 https://github.com/RetroPie/RetroPie-Setup

    echo ""
    echo "============================================"
    echo " apply odroid c1 patches...                 "
    echo "============================================"
    # apply some custom patches for Odroid c1 to make compilation works
    patch $RETROPIE_SETUP_PATH/scriptmodules/libretrocores/lr-flycast.sh $ODROIDC1_BUILD_PATH/patches/lr-flycast.patch
	cp $ODROIDC1_BUILD_PATH/patches/xmb.c /root/
	patch $RETROPIE_SETUP_PATH/scriptmodules/emulators/retroarch.sh $ODROIDC1_BUILD_PATH/patches/retroarch.sh.patch
	

    echo ""
    echo "============================================"
    echo " build wanted retropie packages...          "
    echo "============================================"
    # Build Retroarch / Retropie packages
    cd $RETROPIE_SETUP_PATH
    for package in ${PACKAGES[@]}
    do
	echo "----------- start $package -------------"
        ./retropie_packages.sh $package
	echo "--------- finished $package ------------"
	echo ""
 	# set dedicated folder for pcengine CDrom games
 	mkdir /root/RetroPie/roms/pce-cd/
    done
    # some mali libs seems to be overriden during compilation...
    apt-get -y install --reinstall  mali-fbdev


    echo ""
    echo "============================================"
    echo " create symlink for libretro core...        "
    echo "============================================"
    # make symlink for libretro cores so retroarch find them for gamelists creation
    cd /opt/retropie/libretrocores/
    find . -type f -name *.so -exec ln -s {} \;
 
    echo ""
    echo "============================================"
    echo " build amiberry libretro wrapper...         "
    echo "============================================"
    # make amiberry launcher
    cd /root
    git clone https://github.com/jit06/libretro-amiberry-launcher
    cd libretro-amiberry-launcher
    make
    cp amiberry_launcher_libretro.so /opt/retropie/libretrocores/

	echo ""
    echo "============================================"
    echo " Install custom retroarch theme...          "
    echo "============================================"
	cp -R $ODROIDC1_BUILD_PATH/skin/Retroarch/GamOdroid_theme /root/.config/retroarch/

    echo ""
    echo "============================================"
    echo " set retroarch to start on boot...          "
    echo "============================================"
    # copy systemd service to start retroarch at boot
    cp $ODROIDC1_BUILD_PATH/scripts/start_retroarch.sh /opt/
    cp $ODROIDC1_BUILD_PATH/systemd/retroarch.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable retroarch
}
