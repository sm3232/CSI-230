#!/bin/bash
if [[ $# -lt 2 ]]; then
	echo "Not enough args.";
	echo "Usage: c2.bash [log file] [ioc file]";
	exit 1;
fi
logs=$(grep -f "$2" "$1" -n | cut -d' ' -f1,4,7 | tr -d '[')
printf '%s\n' "$logs" | tr -d '\r' > report.txt
