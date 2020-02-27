#!/bin/bash

function retroarch_optimize() {

    # amiberry : set FAST_COPPER=TRUE in all <hardware> to make games playable on C1
    sed -i "s/<hardware>/<hardware>FAST_COPPER=TRUE/" /opt/retropie/emulators/amiberry/whdboot/game-data/whdload_db.xml


    #TODO : copy corespecific options to make them run fine on C1

}
