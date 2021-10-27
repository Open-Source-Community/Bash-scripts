#!/bin/bash

if [[ ! command -v ffmpeg ]]
then
  echo "Installing ffmpeg"
  sudo apt-get install ffmpeg
fi

FILE="$1"

if [ -z "$FILE" ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

ffmpeg -i "$1" -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "new-$1"