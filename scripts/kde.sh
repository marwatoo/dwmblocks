#!/bin/bash
. ~/.config/dwm/colors.sh
. ~/.config/dwm/char.sh

icon="󰺙"
ee="󱨂"
sp="󱗜"
icon2=""

# Run KDE Connect once
data=$(kdeconnect-cli -a 2>/dev/null)

# Extract first reachable + paired device
device_line=$(echo "$data" | grep "(paired and reachable)" | head -n 1)

# If no device found
if [ -z "$device_line" ]; then
    echo ""
    exit 0
fi

# Extract device name before the colon
device_name=$(echo "$device_line" | sed 's/^- \(.*\):.*/\1/')
device_id=$(echo "$device_line" | awk -F ': ' '{print $2}' | cut -d ' ' -f 1)
device_bat=$(qdbus6 org.kde.kdeconnect /modules/kdeconnect/devices/${device_id}/battery org.kde.kdeconnect.device.battery.charge)
device_state=$(qdbus6 org.kde.kdeconnect /modules/kdeconnect/devices/${device_id}/battery org.kde.kdeconnect.device.battery.isCharging)




kname=$(switch_string "$device_name")
kbat=$(switch_string "$device_bat")


# Output


# Check the value of device_state
if [ "$device_state" == "true" ]; then
    echo "${clwin}${icon}${kname}${sp}${cend}${clbat}${kbat}${ee}󰧜${cend}"
elif [ "$device_state" == "false" ]; then
    echo "${clwin}${icon}${kname}${sp}${kbat}${ee}${cend}"
else
    echo "${clwin}${icon}${kname}${cend}"
fi

