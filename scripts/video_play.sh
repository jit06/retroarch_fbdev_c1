#/bin/bash

MEDIA_PATH="media/videos"
VIDEO_EXT="mp4"
FILENAME=$(basename "${1}")
FILENAME_NOEXT="${FILENAME%.*}"
FILE_PATH="${1%/*}"

VIDEO_FILE="$FILE_PATH/$MEDIA_PATH/$FILENAME.$VIDEO_EXT";
VIDEO_FILE_ALT="$FILE_PATH/$MEDIA_PATH/$FILENAME_NOEXT.$VIDEO_EXT"

if [ -f "$VIDEO_FILE" ]; then
	VIDEO_REAL_FILE="$VIDEO_FILE"
elif [ -f "$VIDEO_FILE_ALT" ]; then
	VIDEO_REAL_FILE="$VIDEO_FILE_ALT"
else
	/opt/video_blank.sh 1
	exit
fi

dd if=/root/.mplayer/fifo iflag=nonblock of=/dev/null

SIZE=$(fbset -s -fb /dev/fb1 | grep geometry | awk '{b=$4":"$5; print b}')
mplayer -vo fbdev2:/dev/fb1 -vf scale=$SIZE -fs -slave -input file=/root/.mplayer/fifo "$VIDEO_REAL_FILE" &
