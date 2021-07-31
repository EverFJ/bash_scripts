#!/bin/bash

### Mass convert media files with ffmpeg

# Files path
function read_source_files() {
	echo "Enter path of files to convert :"
	echo "(Ex: /home/user/Videos/*.avi ou ../*.*)"
	read -r source_files
	source_directory=$(dirname "${source_files}" | sort | uniq )

	if [[ ! -d "${source_directory}" ]]; then
		echo "No files there. Exiting..."
		exit 1
	fi
}

# Extension choice
function read_extension() {
	echo "Enter format you wish to convert the files to :"
	echo "(Ex: mp3, mp4, etc...)"
	read -r extension

	if [[ -z $extension ]]; then
		echo "Non valid extension. Exiting..."
		exit 1
	fi
}

# Loop to convert all files
function convert() {
	for filename in "$source_files"; do

		basepath=${filename%.*}		# Remove extension
		basename=${basepath##*/}	# Remove path

	    ffmpeg -i "${filename}" /home/"$(whoami)"/"${basename}"."${extension}"
	done
	echo "DONE!"
	}

read_source_files
read_extension
convert

ls /home/"$(whoami)"
exit 0
