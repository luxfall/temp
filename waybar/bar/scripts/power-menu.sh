#!/bin/bash

entries="    Lock
    Suspend
󰒲    Hibernate
    Reboot
󰍃    Logout
    Shutdown
    Reboot into Firmware"

selected_index=$(printf "%b" "$entries" | fuzzel --dmenu --index --mesg="Power Menu" --hide-prompt)
if [ -z "$selected_index" ]; then
        exit 0
fi

case "$selected_index" in
    0)
        hyprlock
        ;;
    1)
        hyprshutdown --no-exit && systemctl suspend
        ;;
    2)
        hyprshutdown --no-exit && systemctl hibernate
        ;;
    3)
        hyprshutdown --no-exit && systemctl reboot
        ;;
    4)
        hyprshutdown --no-exit && hyprctl dispatch 'hl.dsp.exit()'
        ;;
    5)
        hyprshutdown --no-exit && systemctl poweroff
        ;;
    6)
        hyprshutdown --no-exit && systemctl reboot --firmware-setup
        ;;
    *)
        exit 0
        ;;
esac
