#!/bin/bash

# Change this to boot to other system. (e.g. "Ubuntu")
# This text should be long enough to distinguish entry you want to boot.
# For example, "Ubuntu" will not work properly if there is multiple boot entries starts with "Ubuntu".
NAME="Windows"

SUDO=''
ENTRY_TITLE=`grep -i '^menuentry "'"$NAME" /boot/grub/grub.cfg|head -n 1|cut -d"'" -f2`

#Terminal(Non-graphical) environment
if [ -z "$DISPLAY" ]; then 

	# Alert reboot
	echo -e "\e[93mRebooting to $NAME!\e[0m"
	echo "entry: $ENTRY_TITLE"

	# Check if current user is already ROOT
	if [ "$(id -u)" != "0" ]; then SUDO='sudo'; fi

	# Set reboot target
	$SUDO grub-reboot "$ENTRY_TITLE"

	# Abort if reboot target failed
	if [ $? -eq 0 ]; then
		$SUDO reboot
	else
		echo "Reboot interrupted!"
	fi

#Graphical environment
else

	# Check if current user is already ROOT
	if [ "$(id -u)" != "0" ]; then SUDO='pkexec'; fi

	# Set reboot target and reboot
	exec $SUDO sh -c "grub-reboot '$ENTRY_TITLE' && reboot"

fi