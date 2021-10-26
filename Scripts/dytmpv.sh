#!/bin/sh

QUALITIES="1080\n720\n480\n360\n240\n"
DMENU_ARGS="-fn monospace:20"
QUALITY_FMT=""
SAVE_LOCATION=$HOME/Videos

install_deps() {
				DEPS="dmenu xclip mpv youtube-dl"
				APT_CMD=$(which apt)
				PACMAN_CMD=$(which pacman)
				DNF_CMD=$(which dnf)

				notify-send "DYTMPV" "You will be prompted to install the dependencies" 2> /dev/null || \
								printf "${COLOR_GREEND}DYTMPV: Installing Dependencies ${COLOR_WHITE}\n"

				sleep 3
				
				if [ ! -z $PACMAN_CMD ]; then
								pkexec pacman -Sy $DEPS libnotify --no-confirm 2> /dev/null || sudo pacman -Sy $DEPS
				elif [ ! -z $APT_CMD ]; then
								pkexec apt install $DEPS libnotify-bin -y 2> /dev/null || sudo apt install $DEPS
				elif [ ! -z $DNF_CMD ]; then
								pkexec dnf install $DEPS 2> /dev/null || sudo dnf install $DEPS
				fi || exit 1

				 notify-send "DYTMPV" "Dependencies have been installed successfully" 2> /dev/null || \
								printf "${COLOR_GREEND}YTMPV: Dependencies have been install successfully ${COLOR_WHITE}\n"
}

check_deps() {

				which dmenu > /dev/null && \
				which xclip > /dev/null && \
				which mpv > /dev/null && \
				which youtube-dl > /dev/null || install_deps
}

get_quality_fmt() {
				CHOISE="$(printf "$QUALITIES" | dmenu -l 10 -p "Quality:" $DMENU_ARGS)"
				QUALITY_FMT="bestvideo[height<=$CHOISE]+bestaudio"
}

watch_video() {
				printf
}

check_deps

VID_URL=$(xclip -selection clipboard -o)

notify-send "DYTMPV" "Video $VID_URL"

CHOISE=$(printf "Watch\nDownload\n" | dmenu -p "Video: $VID_URL" $DMENU_ARGS)

if [ "$CHOISE" = "Watch" ]; then
				get_quality_fmt
				mpv --ytdl-format="$QUALITY_FMT" "$VID_URL"
elif [ "$CHOISE" = "Download" ]; then
				get_quality_fmt
				mkdir $SAVE_LOCATION -p
				notify-send "DYTMPV" "Downloading $VID_URL" -t 3
				youtube-dl -f "$QUALITY_FMT" $VID_URL -o "$SAVE_LOCATION/%(title)s.%(ext).s" && \
								notify-send "DYTMPV" "Download completed successfully" || \
								notify-send "DYTMPV" "Failed to download the video"
fi


