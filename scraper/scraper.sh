#!/bin/bash

RETROARCH_DIR=/root/.config/retroarch
RETROPIE_ROMS=/root/RetroPie/roms
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
SKYSCRAPER_CMD=/opt/retropie/supplementary/skyscraper/Skyscraper

# match Retropie's system name with Retroarch's one
declare -A DIRS=(	[amiga]="Commodore - Amiga"
					[amstradcpc]="Amstrad - CPC"
					[atari2600]="Atari - 2600"
					[atari5200]="Atari - 5200"
					[atari7800]="Atari - 7800"
					[atarilynx]="Atari - Lynx"
					[dreamcast]="Sega - Dreamcast"
					[gamegear]="Sega - Game Gear"
					[gb]="Nintendo - Game Boy"
					[gba]="Nintendo - Game Boy Color"
					[gbc]="Nintendo - Game Boy Advance"
					[mame2003]="MAME"
					[mastersystem]="Sega - Master System - Mark III"
					[megadrive]="Sega - Mega Drive - Genesis"
					[n64]="Nintendo - Nintendo 64"
					[nes]="Nintendo - Nintendo Entertainment System"
					[neogeo]="FBNeo - Arcade Games"
					[ngp]="SNK - Neo Geo Pocket"
					[ngpc]="SNK - Neo Geo Pocket Color"
					[pce-cd]="NEC - PC Engine CD - TurboGrafx-CD"
					[pcengine]="NEC - PC Engine - TurboGrafx 16"
					[psx]="Sony - PlayStation"
					[sega32x]="Sega - 32X"
					[segacd]="Sega - Mega-CD - Sega CD"
					[snes]="Nintendo - Super Nintendo Entertainment System"
					[satellaview]="Nintendo - Satellaview"
					[wonderswan]="Bandai - WonderSwan"
					[wonderswancolor]="Bandai - WonderSwan Color"
					[vectrex]="GCE - Vectrex"
					[zxspectrum]="Sinclair - ZX Spectrum"
				)


echo ""

for retropie_dir in "${!DIRS[@]}"; do 
	
	# do nothing if the system is not used
	if [ ! -d "$RETROPIE_ROMS/$retropie_dir" ]; then
		echo "no $retropie_dir directory: skipped"
		echo ""
		continue
	fi

	echo "=================================="
	echo " system '${DIRS[$retropie_dir]}'"
	echo "=================================="

	# scrap with skyscraper in system roms dir
	if [ ! -d "$RETROPIE_ROMS/$retropie_dir/media" ]; then
		mkdir "$RETROPIE_ROMS/$retropie_dir/media"
	fi

	# handle custom system dir
	if [ "$retropie_dir" = "pce-cd" ]; then
		system="pcengine"
	elif [ "$retropie_dir" = "satellaview" ]; then
		system="snes"
	else
		system=$retropie_dir
	fi

	# scrap ! you may change "screenscraper" value to whatever skyscraper source you prefer
	$SKYSCRAPER_CMD -p $system \
					-g "$RETROPIE_ROMS/$retropie_dir" \
					-o "$RETROPIE_ROMS/$retropie_dir/media" \
					-s screenscraper \
					--unattend \
					--relative \
					--nohints \
					--nomarquees \
					-u $1:$2

	# point retroarch thumbnails directories to skyscraper one's
	if [ ! -d "$RETROARCH_DIR/thumbnails/${DIRS[$retropie_dir]}" ]; then
		mkdir "$RETROARCH_DIR/thumbnails/${DIRS[$retropie_dir]}"
	fi
	
	cd "$RETROARCH_DIR/thumbnails/${DIRS[$retropie_dir]}"
	rm -R Named_*
	ln -s "$RETROPIE_ROMS/$retropie_dir/media/covers" Named_Boxarts 
	ln -s "$RETROPIE_ROMS/$retropie_dir/media/screenshots" Named_Snaps   
	ln -s "$RETROPIE_ROMS/$retropie_dir/media/wheels" Named_Titles

	# convert skyscraper gamelist to retroarch playlists
	xsltproc --stringparam db_name "${DIRS[$retropie_dir]}.lpl" --stringparam rom_path "$RETROPIE_ROMS/$retropie_dir" "$SCRIPTPATH/skyscraperToPlaylist.xsl" "$RETROPIE_ROMS/$retropie_dir/gamelist.xml" > "$RETROARCH_DIR/playlists/${DIRS[$retropie_dir]}.lpl"

	echo ""
done
