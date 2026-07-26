#!/bin/bash

. ~/.config/dwm/colors.sh
. ~/.config/dwm/char.sh

ee="󱨂"

mycolor=${cl}

bat_path="/sys/class/power_supply/BAT0"
frame_file="/tmp/dwmblocks_battery_frame"

# Read battery
if [ ! -r "$bat_path/capacity" ]; then
    echo "󰞋${ee}"
    exit
fi

cap=$(cat "$bat_path/capacity")
status=$(cat "$bat_path/status")

# FULL BATTERY → special output
if [ "$cap" -eq 100 ]; then
    echo "${clch}󰇽󰎤󰎡󰎡${ee}${cend}"
    exit
fi


prefix=""
icon2=""

if [ "$status" = "Charging" ]; then
    prefix=""
    mycolor=${clch}
    icon2=""
    # icon2="󰋠"
    

elif [ "$status" = "Discharging" ]; then
    prefix="󰦓"
    mycolor=${cldi}
    icon2="󰧖"
    #icon2="󰧖"
else
    prefix="󰿠"       # fallback icon for unknown status
    mycolor=${cldi}  # fallback color (define clun if needed)
    icon2=""       # fallback secondary icon
fi


cap=$(switch_string "$cap")

# echo "${mycolor}${prefix} ${icon} ${cap}${ee}${cend}"
echo "${mycolor}${prefix}${icon2}${cap}${ee}${cend}"

