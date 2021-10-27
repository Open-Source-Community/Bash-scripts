#!/bin/bash

# menu for system infromation 
clear

cat << EOF
Please Select:g
    1. Display System Information
    2. Display Disk Space
    3. Display kernel version
    4. display GPU
    0. Quit
EOF
echo -n 'Enter selection [0-4]: '
read -r sel

case $sel in
	0) echo "Program terminated.";;
	1) echo "Hostname: $HOSTNAME"; uptime;;
	2) df -h;;
	3) uname -r;;
    4) glxinfo -B | grep 'OpenGL renderer string' ;;
	*)
		echo "Invalid entry." >&2
		exit 1
esac