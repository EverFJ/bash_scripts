#!/bin/bash

### You need to install spd_say text to speech utility for this to work

time="$1"
countdown(){
    date1=$((`date +%s` + $1));
    while [ "$date1" -ge `date +%s` ]; do
    	## Is this more than 24h away?
    	days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    	echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    	sleep 0.1
    done
}
if [[ $# -eq 0 ]]; then
	echo "You need to put a number of minutes as an argument"
	exit 0
else
	countdown 60*$1 && spd-say "now now now"
fi
clear
exit 0


