#!/bin/bash
CURRENT_VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n1)
TARGET_VOL=$(( (CURRENT_VOL + 5) > 100 ? 100 : CURRENT_VOL + 5 ))
[[ "$CURRENT_VOL" =~ ^[0-9]+$ ]] && pactl set-sink-volume @DEFAULT_SINK@ "${TARGET_VOL}%"
echo "音量调整至：${TARGET_VOL}%"
