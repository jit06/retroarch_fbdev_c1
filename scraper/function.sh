#!/bin/bash

function scrap() {
	system=$1 
	retropie_dir=$2

	msg "scrap '${DIRS[$retropie_dir]}'"
	
	# scrap ! you may change "screenscraper" value to whatever skyscraper source you prefer
	$SKYSCRAPER_CMD -p $system \
					-g "$RETROPIE_ROMS/$retropie_dir" \
					-o "$RETROPIE_ROMS/$retropie_dir/media" \
					-i "$RETROPIE_ROMS/$retropie_dir" \
					-s $SCAPER_SOURCE \
					--flags videos,unattend,relative,nohints,nomarquees \
					-u $SCRAPER_USER:$SCRAPER_PWD
}

function gamelist() {
	system=$1 
	retropie_dir=$2

	msg "gamelist '${DIRS[$retropie_dir]}'"
	
	# generate gamelist
	$SKYSCRAPER_CMD -p $system \
					-g "$RETROPIE_ROMS/$retropie_dir" \
					-o "$RETROPIE_ROMS/$retropie_dir/media" \
					-i "$RETROPIE_ROMS/$retropie_dir" \
					--flags videos,unattend,relative,nohints,skipped,nomarquees
}

function playlist() {

	msg "playlist '${DIRS[$retropie_dir]}'"

	# point retroarch thumbnails directories to skyscraper one's
	if [ ! -d "$RETROARCH_DIR/thumbnails/${DIRS[$retropie_dir]}" ]; then
		mkdir "$RETROARCH_DIR/thumbnails/${DIRS[$retropie_dir]}"
	fi
	
	cd "$RETROARCH_DIR/thumbnails/${DIRS[$retropie_dir]}"
	rm -Rf Named_*
	ln -s "$RETROPIE_ROMS/$retropie_dir/media/covers" Named_Boxarts 
	ln -s "$RETROPIE_ROMS/$retropie_dir/media/screenshots" Named_Snaps   
	ln -s "$RETROPIE_ROMS/$retropie_dir/media/marquees" Named_Titles

	# convert skyscraper gamelist to retroarch playlists
	xsltproc --stringparam db_name "${DIRS[$retropie_dir]}.lpl" --stringparam rom_path "$RETROPIE_ROMS/$retropie_dir" "$SCRIPTPATH/skyscraperToPlaylist.xsl" "$RETROPIE_ROMS/$retropie_dir/gamelist.xml" > "$RETROARCH_DIR/playlists/${DIRS[$retropie_dir]}.lpl"
}


function headermsg() {
	echo ""
	echo ""
	echo "=========================================================="
	echo " $1														"
	echo "=========================================================="
	echo ""
}

function msg() {
	echo ""
	echo ">>> $1 <<<"
	echo ""
}

function display_help() {
   echo
   echo "Scrap all roms found in '$RETROPIE_ROMS' and generate retroarch playlists"
   echo "Paths can be modified in setting.sh"
   echo "/!\\ Scraping can take a very long time if you have a lot of roms"
   echo
   echo "Without any option, it will just show detected rom folders"
   echo
   echo "Syntax: scraper.sh [-s|-g|-p|-U|-P|-S]"
   echo "options:"
   echo "	-s		Do scrap process for each non empty supported rom folder"
   echo "	-g		Generate gamelist (gamelist.xml) for every rom folder that have been scraped"
   echo "	-p		Generate retroarch playlist (.pl) for each gamelist"
   echo "	-U <user>     	set the user name to use for the scrap process (default: SCRAPER_USER in setting.sh)"
   echo "	-P <password>	set the password to use for the scrap process (default: SCRAPER_PWD in setting.sh)" 
   echo "	-S <source>    	set the skyscraper source (default: screenscraper)"
   echo
   echo "Example to scrap all roms and generate retroarch playlist:" 
   echo "	./scraper.sh -s -g -p"
   echo
   
}

