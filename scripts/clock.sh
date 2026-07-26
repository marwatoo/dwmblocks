#!/bin/bash

. ~/.config/dwm/colors.sh
. ~/.config/dwm/char.sh

# Digit icons
e0="󰎡"
e1="󰎤"
e2="󰎧"
e3="󰎪"
e4="󰎭"
e5="󰎱"
e6="󰎳"
e7="󰎶"
e8="󰎹"
e9="󰎼"
ee="󱗜"  # colon
dicon="󰵆"
# Get current hour and minute
hour=$(date '+%H')
minute=$(date '+%M')

# Convert hour to 12h clock for clock icon
h12=$((10#$hour % 12))
[ "$h12" -eq 0 ] && h12=12

# Replace digits in hour and minute
day=$(date +"%d")
month=$(date +"%m")
year=$(date +"%Y")
year2=$(date +"%Y" | cut -c3-4)
year2=$(switch_string "$year2")

day_name=$(date +"%A" | cut -c1-3)
month_name=$(date +"%B" | cut -c1-4)
day_name=$(switch_string "$day_name")
month_name=$(switch_string "$month_name")

hour_icon=$(switch_string "$hour")
minute_icon=$(switch_string "$minute")

day_icon=$(switch_string "$day")
month_icon=$(switch_string "$month")
year_icon=$(switch_string "$year")

# Print clock icon + time with custom digits and colon
# echo "${cltm}$icon $hour_icon$ee$minute_icon${cend} ${cldt}$day_icon$eee$month_icon$eee$year_icon${cend}"
# echo "${cltm}${hour_icon}${ee}${minute_icon}${cend} ${cldt}${day_name}${ee}${day_icon}${ee}${month_name}${ee}${year2}${cend}"
echo "${cltm}${dicon}${hour_icon}${ee}${minute_icon}${cend}"

