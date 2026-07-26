#!/bin/bash

. ~/.config/dwm/colors.sh
. ~/.config/dwm/char.sh

layout=$(xkb-switch 2>/dev/null)
[ -z "$layout" ] && layout="??"

case "$layout" in
    fr) icon="fr" ;;
    ma) icon="ma" ;;
    *)  icon="kb"  ;;   # fallback icon
esac
icon=$(switch_string "$icon")
echo "${clkey}󰏬$icon${cend}"

