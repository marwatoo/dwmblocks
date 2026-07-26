#!/bin/bash
. ~/.config/dwm/colors.sh
. ~/.config/dwm/char.sh

icon="󰎃"
ee="󱨂"
br=$(brightnessctl | awk -F'[()%]' '/Current brightness/ {print $2}')
br=$(switch_string "$br")
echo "${clpr}${icon}${br}${ee}${cend}"



