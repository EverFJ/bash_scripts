#!/bin/bash

### You need to install spd-say text to speech utility for this to work
### And to have the spd_say file in the same dir 

if [[ $# != 2 ]]; then
	echo "Usage : alarm n m|h --> set the alarm in n minute(s)|hour(s)"
	exit 0
fi

time_number="$1"

if [[ "$2" == "m" ]]; then
	time_format="minute"
elif [[ "$2" == "h" ]]; then
	time_format="hour"
else
	echo "Second argument needs to be m(inute) or h(our)!"
	exit 1
fi
	

function alarm_set() {
	at -f ./spd_say now + "$time_number" "$time_format" > /dev/null 2>&1
	echo -e "Alarm will speak in ""$time_number"" ""$time_format""(s).\n$(atq)"
}

alarm_set

exit 0
