#!/bin/bash

# Parameter 1: Entry to boot next time. (e.g. "Ubuntu")
# This should be long enough to distinguish entry you want to boot.
# ex) $1="Ubuntu" won't work if there are multiple boot entries start with "Ubuntu".
if [ -z "$1" ] ; then
	echo Usage: $0 ENTRY
	exit 1;
fi
NAME=$1

SUDO=''
ENTRY_TITLE=`grep -i '^menuentry "'"$NAME" /boot/grub/grub.cfg|head -n 1|cut -d"'" -f2`

#Terminal(Non-graphical) environment OR already sudo-authenticated
if [ -z "$DISPLAY" ] || sudo -n true 2>/dev/null ; then

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
	$SUDO sh -c "grub-reboot '$ENTRY_TITLE' && reboot"

fi
