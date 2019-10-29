# Scripts for automated multiboot
Select system for next boot without any keyboard press in GRUB!  
Script has tested on Ubuntu 16.04, 18.04 with Windows 10.

## Basic Usage
+ __Default boot selection should be "Previously booted entry" in GRUB settings.__ Result of command below should be `GRUB_DEFAULT="saved"`.  
```
$ cat /etc/default/grub | grep GRUB_DEFAULT
```
+ Copy script file under `/usr/bin`, then script can be called from everywhere; not only in GUI desktop environment, but also CLI environment(SSH access, ...). Use `*.desktop file` in GUI environment for quick use!


## Files included

### `bootwindows.sh`
Find Windows installation and boot to it.  
__Designed to be used in _single Windows_ installed environment!__ On system with __multiple Windows installed__ or __multiple boot entries__ whose name starts with "Windows", this script may not work as expected.

### `bootwindows.desktop`
Desktop icon entry for `/usr/bin/bootwindows.sh`.  
Activate this entry inside application menu with:
```
$ cp bootwindows.desktop ~/.local/share/applications/
```

## To use this script for other OS boot
To boot to other system than windows,
1. Just modify `NAME="Windows"` in `bootwindows.sh` to other system name.
2. rename this file and copy under `/usr/bin`.
3. That should work just as `bootwindows.sh`.

If desktop entry is needed, edit `bootwindows.desktop` file to point the script file you just edited, and locate it under `~/.local/share/applications/`.