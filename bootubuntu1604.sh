#!/bin/bash

# Change this to boot to other system. (e.g. "Ubuntu")
# This text should be long enough to distinguish entry you want to boot.
# For example, "Ubuntu" will not work properly if there is multiple boot entries starts with "Ubuntu".
NAME="Ubuntu 16.04"

SUDO=''
if [ "$(id -u)" != "0" ] || sudo -n true 2>/dev/null;  then
	if [ -z "$DISPLAY" ]; then
		SUDO='sudo'
	else
		SUDO='pkexec'
	fi
fi
ENTRY_TITLE=`grep -i '^menuentry "'"$NAME" /boot/grub/grub.cfg|head -n 1|cut -d"'" -f2`

echo -e "\e[93mRebooting to $NAME!\e[0m (\"$ENTRY_TITLE\")"
$SUDO grub-reboot "$ENTRY_TITLE"
$SUDO reboot
