#!/bin/bash

SCRAPER_USER="anon"
SCRAPER_PWD="anon"
SCAPER_SOURCE="screenscraper"

RETROARCH_DIR=/root/.config/retroarch
RETROPIE_ROMS=/root/RetroPie/roms
SKYSCRAPER_CMD=/opt/retropie/supplementary/skyscraper/Skyscraper

# match Retropie's system name with Retroarch's one
# DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU DO !
declare -A DIRS=(  	[amiga]="Commodore - Amiga"
					[amstradcpc]="Amstrad - CPC"
					[atari2600]="Atari - 2600"
					[atari5200]="Atari - 5200"
					[atari7800]="Atari - 7800"
					[atarilynx]="Atari - Lynx"
					[dreamcast]="Sega - Dreamcast"
					[gamegear]="Sega - Game Gear"
					[gb]="Nintendo - Game Boy"
					[gba]="Nintendo - Game Boy Advance"
					[gbc]="Nintendo - Game Boy Color"
					[fds]="Nintendo - Family Computer Disk System"
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
