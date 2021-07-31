#!/bin/bash

### File copying utility

host_ip="42.42.42.42"
scp_user="USER"
scp_port="22"
file2copy="$1"
dest_dir="$2"
files_list=""

if [ $# -eq 0 ]; then
	echo "Usage: $0 dir/file dest_dir"
        echo "copying from remote vps"	

function scp_copy_from_remote_host () {
	HOST_IP="$1"
	SCP_USER="$2"
	SCP_PORT="$3"
	FILE2COPY="$4"
	DEST_DIR="$5"

	scp -P $SCP_PORT "$SCP_USER"@"$HOST_IP":"$FILE2COPY" "$DEST_DIR"
}


scp_copy_from_remote_host "$host_ip" "$scp_user" "$scp_port" "$file2copy" "$dest_dir"
	