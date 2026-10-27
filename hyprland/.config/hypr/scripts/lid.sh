#!/bin/bash
STATE_FILE="/tmp/hypr_lid_state"
CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null)

if [[ $1 == "close" ]]; then
    if [[ "$CURRENT_STATE" != "closed" ]]; then
        echo "closed" > "$STATE_FILE"
        /usr/bin/hyprctl eval 'hl.monitor({output="eDP-1", disabled=true})'
    fi
else
    if [[ "$CURRENT_STATE" != "open" ]]; then
        echo "open" > "$STATE_FILE"
        /usr/bin/hyprctl eval 'hl.monitor({output="eDP-1", disabled=false, mode="1920x1080@60", position="auto", scale="1.33"})'
    fi
fi
