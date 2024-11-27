#!/bin/bash
#
max_value=$(brightnessctl m)
current_value=$(brightnessctl g)
current_value_percent=$((current_value * 100 / max_value))
operation=${1//[^+-]/}

notify() {
    notify-send "$1%" -t 500 --icon ~/.config/dunst/icons/brightness.svg
}

# Function to set brightness to 0.1% if current_value is 0
set_minimum_brightness() {
    new_value=$((max_value / 1000))
    brightnessctl s "$new_value"
    notify "0.1"
    exit 0
}

# If brightness is below 1%, adjust brightness by 0.1% instead of user input
if [ "$current_value_percent" -le 1  ] && [[ "$1" == *"%"* ]]; then
    tenth=$((max_value / 1000))
    case "$operation" in
        "+") brightnessctl s "$tenth+" ;;
        "-") brightnessctl s "$tenth-" ;;
    esac

    current_value=$(brightnessctl g)
    [ "$current_value" -eq 0 ] && set_minimum_brightness
    current_value_percent=$((current_value * 1000 / max_value))
    notify "0.$current_value_percent"
    exit 0
fi

# If brightness is below 5%, adjust brightness by 1% instead of user input
if [ "$current_value_percent" -le 5 ] && [[ "$1" == *"%"* ]]; then
    case "$operation" in
        "+") brightnessctl s "1%+" ;;
        "-") brightnessctl s "1%-" ;;
    esac

    current_value=$(brightnessctl g)
    [ "$current_value" -eq 0 ] && set_minimum_brightness
    current_value_percent=$((current_value * 100 / max_value))
    notify "$current_value_percent"
    exit 0
fi

# Set the brightness based on user input
brightnessctl s "$1"
current_value=$(brightnessctl g)
[ "$current_value" -eq 0 ] && set_minimum_brightness

# Recalculate and notify the user of the current brightness percentage
current_value_percent=$((current_value * 100 / max_value))
notify "$current_value_percent"
