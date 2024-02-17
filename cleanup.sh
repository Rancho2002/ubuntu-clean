#! /bin/bash
sudo apt-get update #Updates the package lists for upgrades and new installations
sudo apt-get upgrade -y	#upgrade all softwares to latest version
sudo apt-get autoremove && sudo apt-get autoclean #autoremove removes packages that were automatically installed but are no longer required and autoclean removes unnecessary packages and files from the package cache
sudo apt-get clean #Deletes all packages from the package cache.
sudo journalctl --rotate #Rotates and archives the journal files
sudo journalctl --vacuum-time 1d #Clears all log files older than 1 day.
rm -rf ~/.cache/thumbnails/* #Removes thumbnail cache files
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
      sudo snap remove "$snapname" --revision="$revision"
    done

if command -v notify-send &> /dev/null; then
    notify-send "Cleaning done"
else
    echo "Cleaning done"
fi
