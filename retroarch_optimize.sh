#!/bin/bash

function retroarch_optimize() {

	echo ""
    echo "============================================"
    echo " amiberry fast_copper and frameskip for all games..."
    echo "============================================"
    # amiberry : set FAST_COPPER=TRUE in all <hardware> to make a500 games playables on C1
    sed -i "s/FAST_COPPER=FALSE/FAST_COPPER=TRUE/" /opt/retropie/emulators/amiberry/whdboot/game-data/whdload_db.xml

    cp $ODROIDC1_BUILD_PATH/configs/hostprefs.conf /opt/retropie/emulators/amiberry/whdboot/

	echo ""
    echo "============================================"
    echo " copy retroarch default settings			  "
    echo "============================================"
    # copy retroarch config to make them run fine on C1
    cp $ODROIDC1_BUILD_PATH/configs/retroarch* /root/.config/retroarch/
    rm /opt/retropie/emulators/retroarch/retroarch.cfg
    ln -s /root/.config/retroarch/retroarch.cfg /opt/retropie/emulators/retroarch/retroarch.cfg

    # copy fbneo dat files
    cp $ODROIDC1_BUILD_PATH/configs/*.dat /root/.config/retroarch/

    # copy amiberry config file
    cp $ODROIDC1_BUILD_PATH/configs/amiberry.conf /opt/retropie/emulators/amiberry/conf/
}
