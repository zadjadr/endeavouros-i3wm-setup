#!/bin/bash
#
max_value=$(brightnessctl m)
current_value=$(brightnessctl g)
current_value_percent=$((current_value * 100 / max_value))

# Function to set brightness to 1% if current_value is 0
set_minimum_brightness() {
    new_value=$((max_value / 100))
    brightnessctl s "$new_value"
    notify-send "󰃠 1%" -t 500
    exit 0
}

# If brightness is below 5%, adjust brightness by 1% instead of user input
if [ "$current_value_percent" -lt 5 ] && [[ "$1" == *"%"* ]]; then
    operation=${1//[^+-]/}
    case "$operation" in
        "+") brightnessctl s "1%+" ;;
        "-") brightnessctl s "1%-" ;;
    esac

    current_value=$(brightnessctl g)
    [ "$current_value" -eq 0 ] && set_minimum_brightness
    current_value_percent=$((current_value * 100 / max_value))
    notify-send "󰃠 $current_value_percent %" -t 500
    exit 0
fi

# Set the brightness based on user input
brightnessctl s "$1"
current_value=$(brightnessctl g)
[ "$current_value" -eq 0 ] && set_minimum_brightness

# Recalculate and notify the user of the current brightness percentage
current_value_percent=$((current_value * 100 / max_value))
notify-send "󰃠 $current_value_percent %" -t 500
