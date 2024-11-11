#! /bin/bash

logFile="/var/log/apache2/access.log"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
  cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

function displayOnlyPages(){
  cat "$logFile" | grep "GET " | cut -d ' ' -f 7 | sort -n | uniq -c
}

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

function frequentVisitors(){
  histogram | sed -e 's/^[[:space:]]*//' | awk '$1 > 10 {print}'
}

function suspiciousVisitors(){
  displayAllLogs | grep -f ioc.txt | cut -d ' ' -f 1 | sort -n | uniq -c
}

while :
do
	echo "Please select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
  echo "[3] Display only pages"
	echo "[4] Histogram"
	echo "[5] Frequent visitors"
	echo "[6] Suspicious visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

  elif [[ "$userInput" == "3" ]]; then 
    echo "Displaying only pages:"
    displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "5" ]]; then
		echo "Frequent visitors:"
    frequentVisitors

	elif [[ "$userInput" == "6" ]]; then
		echo "Suspicious visitors:"
    suspiciousVisitors

  else echo "Invalid input.";
	fi
done

