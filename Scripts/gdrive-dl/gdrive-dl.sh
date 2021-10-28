#!/bin/bash

LINK=$1

if [[ $(grep -q 'https://drive\.google\.com.*id=.*' <<< "$LINK") ]]
then
    echo "Invalid link: $LINK"
    exit 1
fi

echo "Downloading $LINK"
FILEID=$(grep -o 'id=.*' <<< "$LINK" | cut -d '=' -f 2)
wget --content-disposition "https://drive.google.com/uc?export=download&id=$FILEID" && echo "Downloaded Successfully" || echo "Download Failed"