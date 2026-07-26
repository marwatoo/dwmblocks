#!/usr/bin/env bash

echars_array=(
    "󰬈"  # a
    "󰬉"  # b
    "󰬊"  # c
    "󰬋"  # d
    "󰬌"  # e
    "󰬍"  # f
    "󰬎"  # g
    "󰬏"  # h
    "󰬐"  # i
    "󰬑"  # j
    "󰬒"  # k
    "󰬓"  # l
    "󰬔"  # m
    "󰬕"  # n
    "󰬖"  # o
    "󰬗"  # p
    "󰬘"  # q
    "󰬙"  # r
    "󰬚"  # s
    "󰬛"  # t
    "󰬜"  # u
    "󰬝"  # v
    "󰬞"  # w
    "󰬟"  # x
    "󰬠"  # y
    "󰬡"  # z
)

e_array=(
    "󰎡"  # 0
    "󰎤"  # 1
    "󰎧"  # 2
    "󰎪"  # 3
    "󰎭"  # 4
    "󰎱"  # 5
    "󰎳"  # 6
    "󰎶"  # 7
    "󰎹"  # 8
    "󰎼"  # 9
)

switch_string() {
    local input="$1"
    local output=""
    local char lower index

    # Accent → icon mapping (using echars_array icons)
    declare -A accent_map=(
        ["à"]="${echars_array[0]}"
        ["á"]="${echars_array[0]}"
        ["â"]="${echars_array[0]}"
        ["ä"]="${echars_array[0]}"
        ["æ"]="${echars_array[0]}${echars_array[4]}"

        ["è"]="${echars_array[4]}"
        ["é"]="${echars_array[4]}"
        ["ê"]="${echars_array[4]}"
        ["ë"]="${echars_array[4]}"

        ["ì"]="${echars_array[8]}"
        ["í"]="${echars_array[8]}"
        ["î"]="${echars_array[8]}"
        ["ï"]="${echars_array[8]}"

        ["ò"]="${echars_array[14]}"
        ["ó"]="${echars_array[14]}"
        ["ô"]="${echars_array[14]}"
        ["ö"]="${echars_array[14]}"

        ["ù"]="${echars_array[20]}"
        ["ú"]="${echars_array[20]}"
        ["û"]="${echars_array[20]}"
        ["ü"]="${echars_array[20]}"

        ["ç"]="${echars_array[2]}"
        ["ñ"]="${echars_array[13]}"
    )

    for (( i=0; i<${#input}; i++ )); do
        char="${input:i:1}"
        lower="${char,,}"

        # 1. Accent mapping
        if [[ -n "${accent_map[$lower]}" ]]; then
            output+="${accent_map[$lower]}"
            continue
        fi

        # 2. Letters
        if [[ "$lower" =~ [a-z] ]]; then
            index=$(( $(printf "%d" "'$lower") - 97 ))
            output+="${echars_array[$index]}"

        # 3. Numbers
        elif [[ "$char" =~ [0-9] ]]; then
            output+="${e_array[$char]}"

        # 4. Other characters
        else
            output+="$char"
        fi
    done

    echo "$output"
}

