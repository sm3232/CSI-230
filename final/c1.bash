#!/bin/bash
# Localhost - server wasn't working for me, off campus network
link="localhost/IOC.html"
html=$(curl -sL "$link")
html=${html#*<table>}
html=${html%</table>*}
html=$(echo "$html" | grep "<td>" | sed 's/^	*//g' | sed -E 's/<\/?td>//g')
html=$(awk 'NR % 2' <<< "$html")
printf '%s\n' "$html" | tr -d '\r' > IOC.txt
