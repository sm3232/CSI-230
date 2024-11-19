#!/bin/bash
page=$(curl -sL "localhost/Assignment.html")

stuff=$(echo "$page" | xmlstarlet format -H -R 2>/dev/null | xmlstarlet select --template --value-of "//tr" 2>/dev/null)

echo "$stuff" | sed 's/&#13;//g' | sed 's/\t//g' | sed '/^[[:space:]]*$/d' \
  | sed '0~2 s/$/;/g' | sed '1~2 s/$/,/g' | tr -d '\n' | tr ';' '\n' \
  | awk -F, '
  BEGIN { print "Temperature\tPressure\tDate-Time" }
  /Temprature,Date-Time/ { reading_mode = "temperature"; next }
  /Pressure,Date-Time/ { reading_mode = "pressure"; next }
  reading_mode == "temperature" { 
    temp_times[$2] = $1 
    all_times[$2] = 1
  }
  reading_mode == "pressure" { 
    press_times[$2] = $1 
    all_times[$2] = 1
  }
  END {
    for (time in all_times) {
      printf "%s\t\t%s\t\t%s\n", 
             temp_times[time] ? temp_times[time] : "N/A", 
             press_times[time] ? press_times[time] : "N/A", 
             time
    }
  }
'
