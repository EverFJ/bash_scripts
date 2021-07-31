#!/bin/bash

### Home directory backup utility
### Modify to suit you needs

part_uuid="slsqdsd-515313-1151-aaaaa-aaaaaaaaaaaa"
dir_to_sync="/home/USER/"
local_dest="/media/.../Backups/USER_backup"
remote_dest="42.42.42.42:USER_backup"

function mount_filesystem () {
	mount PARTUUID="$part_uuid"
}

function umount_filesystem () {
	umount PARTUUID="$part_uuid"
}

function remotesync () {
	DIR_TO_SYNC="$1"
	REMOTE_DEST="$2"
	rsync -auzvh --delete --exclude={'Videos/*','Downloads/*','Music/*','Pictures/*','Downloads/*','.cache/*','.mozilla/*',}\
	 "$DIR_TO_SYNC" "$REMOTE_DEST"
}

function localsync () {
	DIR_TO_SYNC="$1"
	LOCAL_DEST="$2"
	rsync -auzvh --delete --exclude={'Videos/*','Downloads/*','Music/*','Downloads/*','.cache/*','.mozilla/*'}\
	 "$DIR_TO_SYNC" "$LOCAL_DEST"
}

echo "Automatic sync of home directory"
echo "1) local"
echo "2) remote"
echo "3) both"
read -r answer

case $answer in
	1 )
	localsync "$dir_to_sync" "$local_dest"
		;;
	2 )
	remotesync "$dir_to_sync" "$remote_dest"
		;;
	3 )
	remotesync "$dir_to_sync" "$remote_dest"
	localsync "$dir_to_sync" "$local_dest"
			;;
esac

exit 0
