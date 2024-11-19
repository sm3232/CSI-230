#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){
  echo -n "Please Input an Instructor Full Name: "
  read instName

  echo ""
  echo "Courses of $instName :"
  cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | sed 's/;/ | /g'
  echo ""
}

function courseCountofInsts(){
  echo ""
  echo "Course-Instructor Distribution"
  cat "$courseFile" | cut -d';' -f7 | grep -v "/" | grep -v "\.\.\." | sort -n | uniq -c | sort -n -r 
  echo ""
}

function courseOfLocation(){
  echo -n "Input location: "
  read loc
  echo -e "\nCourses of $loc:"
  cat "$courseFile" | grep "$loc" | cut -d';' -f1,2,5,6,7 | column -t -s ";" -o " | " 
}


function availabileCourses(){
  echo -n "Input course code: "
  read code
  echo -e "\nCourses of $code:"
  cat "$courseFile" | grep "$code" | awk -F";" '$4 > 0 {print}' | column -t -s ";" -o " | "
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses with location"
	echo "[4] Display courses with open seats"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts
	
  elif [[ "$userInput" == "3" ]]; then
    courseOfLocation

  elif [[ "$userInput" == "4" ]]; then
    availabileCourses
    
  else echo "Invalid input.";
	fi
done
