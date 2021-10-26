#!/bin/bash

if [ -f "$1" ]; then
	for word in $(cat $1);
	do 
		echo $word
	done | sort | uniq -c | sort -r | awk '{print $2 " " $1}';
else 
	echo $1 "not a file.";
fi
