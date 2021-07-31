#!/bin/bash

### Ultra simple tcp port scanner using /dev

ip="$1"
wait_time="0.2"

function tcp_scan () {

	ip=$1
	for port in $(seq 1 65535); do
		timeout "$wait_time" bash -c "</dev/tcp/$ip/$port && echo Port $port is open! || echo Port $port is closed! > /dev/null" 2> /dev/null || echo "Connection timeout" > /dev/null
	done

}

tcp_scan "$ip"
