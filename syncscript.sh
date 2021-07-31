#!/bin/bash

### Simple backup script using rsync

# destination
echo "Where do you want to backup the home directory? (include USER dir in the path)"
echo -e "Ex:\n42.42.42.42:/home/USER"
echo "/media/.../USER"
read -r destination

# Verification & Syncing
echo "command looks like this :"
echo -e "\n\nrsync -arvh --delete --exclude={'Videos/*','Downloads/*','Music/*','Downloads/*','.cache/mozilla/*','.mozilla/*'} /home/$(whoami)/ $destination\n\n"
echo -e "beware to send it to an empty dir the 1st time,coz it'll delete everything in it...\n"
until [[ $answer =~ y|n ]]; do
    read -rp "OK with that? (y/n):" answer
done
if [[ $answer = y ]]; then
 	    sudo rsync -arvh --delete --exclude={'Videos/*','Downloads/*','Music/*','Downloads/*','.cache/mozilla/*','.mozilla/*'} /home/"$(whoami)"/ "$destination"
else
	echo "Exiting..."
fi
exit
