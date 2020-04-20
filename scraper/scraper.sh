#!/bin/bash


SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

DO_SCRAP=0
DO_GAMELIST=0
DO_PLAYLIST=0

source "$SCRIPTPATH/function.sh"
source "$SCRIPTPATH/settings.sh"


while getopts "hsgpU:P:S:" opt; do
    case "${opt}" in
        s)
            DO_SCRAP=1
            ;;
        g)
            DO_GAMELIST=1
            ;;
        p)
            DO_PLAYLIST=1
            ;;
        U)
            SCRAPER_USER=${OPTARG}
            ;;
        P)
            SCRAPER_PWD=${OPTARG}
            ;;
        S)
            SCAPER_SOURCE=${OPTARG}
            ;;
        h)
            display_help
            ;;
        *)
            display_help
            ;;
    esac
done
shift $((OPTIND-1))


echo
for retropie_dir in "${!DIRS[@]}"; do 
	
	# do nothing if the system is not used
	if [ ! -d "$RETROPIE_ROMS/$retropie_dir" ]; then
		msg "/!\\ no $retropie_dir directory: skipped /!\\"
		continue
	fi

	headermsg "system '${DIRS[$retropie_dir]}'"
	
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


	if [ "$DO_SCRAP" == "1" ]; then
		scrap $system $retropie_dir
	fi
	
	if [ "$DO_GAMELIST" == "1" ]; then
		gamelist $system $retropie_dir
	fi
	
	if [ "$DO_PLAYLIST" == "1" ]; then
		playlist $system $retropie_dir
	fi
done
