#!/bin/bash

### Uses rsync over ssh to upload your website from local to server
### or the other way around.

delete=0
direction="$1"

### Modify to suit your need : 
website_local_path="/home/USER/www/mysuperwebsite/"		# Don't forget the last `/` !
website_remote_path="/var/www/html/"					# Don't forget the last `/` !
server="user@111.111.111.111"

if [[ "$2" == "delete" ]]; then
	delete=1
fi

function syncto () {
	if [[ $delete == 1 ]]; then	
		rsync -e ssh -azvuh --progress --delete "$website_local_path" "$server":"$website_remote_path"
	else
		rsync -e ssh -azvuh --progress "$website_local_path" "$server":"$website_remote_path"
	fi
}


function syncfrom () {
	if [[ $delete == 1 ]]; then	
		rsync -e ssh -azvuh --progress --delete "$server":"$website_remote_path" "$website_local_path"
	else
		rsync -e ssh -azvuh --progress "$server":"$website_remote_path" "$website_local_path"
	fi
}


if [[ $direction == "to" ]]; then
	syncto
elif [[ $direction == "from" ]]; then
	syncfrom
else
	echo -e "websitesync to : sync local dir to remote vps\nwebsitesync from : sync local dir from remote vps"
	echo "You can add \"delete\" as a second argument (see rsync documentation)"
fi


