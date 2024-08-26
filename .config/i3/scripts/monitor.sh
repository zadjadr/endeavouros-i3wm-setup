#!/bin/bash

# Get the list of connected monitors
connected_monitors=$(xrandr --listmonitors | awk 'NR>1 {print $4}')

# Function to disable all monitors except the specified one
disable_others() {
    local keep_monitor=$1
    for monitor in $connected_monitors; do
        if [ "$monitor" != "$keep_monitor" ]; then
            xrandr --output "$monitor" --off
        fi
    done
}

# Function to enable and scale a monitor
enable_and_scale() {
    local monitor=$1
    local scale=$2
    xrandr --output "$monitor" --auto
    xrandr --output "$monitor" --scale "$scale"
}

# Check if DP-4-3 is connected
if echo "$connected_monitors" | grep -q "^DP-4-3$"; then
    disable_others "DP-4-3"
    enable_and_scale "DP-4-3" "1.1x1.1"

# Check if eDP-1 is connected
elif echo "$connected_monitors" | grep -q "^eDP-1$"; then
    disable_others "eDP-1"
    enable_and_scale "eDP-1" "1.5x1.5"

fi

# Set the wallpaper
feh --bg-scale "$1"
