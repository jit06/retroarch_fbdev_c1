![Gamodroid](https://www.bluemind.org/wp-content/uploads/2017/08/logo_gamodroid_c0.png#center)

Odroid C1/C0 optimized retroarch build scripts, based on RetroPie and hardkernel's Ubuntu minimal image.
It uses fbdev (no X) and allows to play confortably a lots of retro consoles including some n64 and dreamcast games (eg. MarioKart, Mario64, CrazyTaxy, Sonic adventure...).
It provides a way to scrap roms with skyscraper and convert de result into retroarch compatible playlists and thumbnails
It has been designed for lowres display (cbvs or 480p).

# Install with binary release
- uncompress de archive with xz (eg. ez -d gamodroidC0_v1.0.img.xz)
- write it to an emmc or sdcard with must be at least 4GB (eg. sudo dd if=gamodroidC0_v1.0.img of=/dev/sdb bs=4M)
- boot you Odroid C1/C1+/C0 with it

# Install with sources
- get official ubuntu minimal 18.04 from Hardkernel and start your Odroid C1/C1+/C0 with it.
- clone this repository in /root (git clone -depth 1 https://github.com/jit06/retroarch_fbdev_c1)
- cd /root/retroarch_fbdev_c1
- ./build.sh
- reboot
- in retroarch: use online updater to update all but cores before doing anything else

Note that it takes several hours to compile and setup everything

# Roms & scraper
- Copy your roms and bios in /root/RetroPie or change retroarch settings or mount any usbkey or sdcard to /root/Retropie (ssh is enabled)
- If you want to use a better scraper than retroarch one's, go to /root/retroarch_fbdev_c1/scraper and launch ./scraper.sh (optionals args are screenscraper login and password, eg. ./scraper.sh mylogin mypassword)

Basicaly, it's a retropie install without emulationstation.

# Main Features
- fast boot : 14 seconds to retroarch interface from cold start
- consoleblank disabled
- cbvs mode set to ntsc (60fps) 
- display set to 720x480 by default (you can change it in build script, but logo and splash image won't have the right size)
- default cpu freq to 1728Mhz
- no boot message, no login message
- console cursor enabled by default (throught amiberry disable it...)
- /var/log in tmpfs (limited to 20Mb), journald log to ram
- some services disabled : rsyslog, ModemManager, pppd-dns, wpa_supplicant, loadcpufreq
- handle overscan : simply create /media/boot/overscan and put your value as "x y width height"
- handle display constrast : simply create /media/boot/contrast and write a positive or negative interger
- handle display brightness : simply create /media/boot/brightness and write a positive or negative interger
- libretro launcher for amiberry so Amiga games (lha) can be started throught retroarch
- fbneo dat files ar present in /root/.config/retroarch to get good naming with retroarch scraper

# Emulated systems
All Odroid C1 retropie emulator are compiled, plus lr-flycast and amiberry, so the following systems are emulated:

- Amstrad - CPC
- Atari - 2600
- Atari - 5200
- Atari - 7800
- Atari - Lynx
- Commodore - Amiga
- Sega - Dreamcast
- Sega - Game Gear
- Nintendo - Game Boy
- Nintendo - Game Boy Color
- Nintendo - Game Boy Advance
- MAME
- Sega - Master System - Mark III
- Sega - Mega Drive - Genesis
- Nintendo - Nintendo 64
- Nintendo - Nintendo Entertainment System
- FBNeo - Arcade Games
- SNK - Neo Geo Pocket
- SNK - Neo Geo Pocket Color
- NEC - PC Engine CD - TurboGrafx-CD
- NEC - PC Engine - TurboGrafx 16
- Sony - PlayStation
- Sega - 32X
- Sega - Mega-CD - Sega CD
- Nintendo - Super Nintendo Entertainment System
- Nintendo - Satellaview
- Bandai - WonderSwan
- Bandai - WonderSwan Color
- GCE - Vectrex
- Sinclair - ZX Spectrum

# Important things to note
- there is no other user than root, password is the default one : odroid
- uhs is enabled by default. Change it if your SDcard is not compatible (boot.ini)
- enable wpa_supplicant if you need wifi : systemctl enable wpa_supplicant
- Amiga emulator (amiberry) is configured to use .lha games (whdload)
- tty1 is disabled, use another one or serial or ssh to login

# Logo and splash screen
The first logo is displayed by uboot. The file boot-logo.bmp is copied to /media/boot, you can change it before launching build.sh or after the installation by changing the image in /media/boot.
This image must be a 24 bit 720x480 BMP image.
 
The splash screen can be generated using the script utils/create_splash.sh, which use the image splash.png.
Basicaly, it installs fbi, display the picture to fbdev, dump /dev/fbo and compress it to lzo.

# Todo (in no particular order)
- correct the bug of boot logo being trashed
- themes retroarch
- shutdown when retroarch quit
- integrate my gpio_joypad as systemd service
- remove uneeded patch (retropie has been update following my demand)
- add mupen64plus-next (for now, it crashes after rom load)
- turn off retroarch logs by default
- assign a default emulator during skyscraper to retroarch playlist conversion
- integrate bash launcher for retroarch and ad menu entries for changing contrast, brightness, cpu freq and display (cbvs / hdmi)
- list known n64 and dreamcast games that run correctly
