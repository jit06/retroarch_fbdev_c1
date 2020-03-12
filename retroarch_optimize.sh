#!/bin/bash

function retroarch_optimize() {

    # amiberry : set FAST_COPPER=TRUE in all <hardware> to make a500 games playables on C1
    sed -i "s/<hardware>/<hardware>FAST_COPPER=TRUE/" /opt/retropie/emulators/amiberry/whdboot/game-data/whdload_db.xml
    
    cp $ODROIDC1_BUILD_PATH/configs/hostprefs.conf /opt/retropie/emulators/amiberry/whdboot/

    # copy retroarch config to make them run fine on C1
    cp $ODROIDC1_BUILD_PATH/configs/retroarch* /root/.config/retroarch/
}
