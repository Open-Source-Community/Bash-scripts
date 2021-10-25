#!/bin/bash
# Created By: Mazen Saad

vidDir=$(xdg-user-dir VIDEOS)
while [[ -d $vidDir ]]
do
    chosenDir=$( ls $vidDir | dmenu -l 4 )
    [[ $? -eq 1 ]] && exit 1
    vidDir="$vidDir/$chosenDir"
    subDirCount=$(find $vidDir -maxdepth 1 -type d | wc -l)
    [[ $subDirCount -eq 1 ]] && break
done
vid=$( ls $vidDir | dmenu -l 5 )
[[ -z $vid ]] || xdg-open "$vidDir/$vid"
