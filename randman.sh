#!/bin/bash

### Randomly chose the title of a manual page

if [[ "$1" == "-h" ]]; then
	echo "no arg : /usr/bin
	1 : /usr/sbin
	2 : /bin
       	3 : /sbin"	       
	exit 0

elif [[ "$1" == "" ]]; then
       man "$(find /usr/bin | shuf -n 1)" | sed -n "/^NAME/ {n;p;q}" ### place this in .bashrc to discover a program each time you launch a terminal...

elif [[ "$1" == "1" ]]; then
	man "$(find /usr/sbin | shuf -n 1)" | sed -n "/^NAME/ {n;p;q}"
elif [[ "$1" == "2" ]]; then
	man "$(find /bin | shuf -n 1)" | sed -n "/^NAME/ {n;p;q}"
elif [[ "$1" == "3" ]]; then
	man "$(find /sbin | shuf -n 1)" | sed -n "/^NAME/ {n;p;q}"
fi


