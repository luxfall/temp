#!/bin/bash

UPTIME=$(awk '{print int($1 * 1000000)}' /proc/uptime)

dunstctl history | jq -r --argjson now "$UPTIME" '
        .data[0][] |
        .timestamp.data as $ts |
        .summary.data as $summary |
        .body.data as $body |
        (($now - $ts) / 1000000) as $diff_s |
        (
                if $diff_s < 60 then
                        "\($diff_s | floor)s"
                elif $diff_s < 3600 then
                        "\(($diff_s / 60) | floor)m"
                elif $diff_s < 86400 then
                        "\(($diff_s / 3600) | floor)h"
                else
                        "\(($diff_s / 86400) | floor)d"
                end
        ) as $time_ago |
        ($summary | gsub("\n"; " ")) as $clean_summary |
        ($body | gsub("\n"; " ")) as $clean_body |
        "[\($time_ago)] \($clean_summary): \($clean_body)"
' | fuzzel --dmenu --mesg "Notifications" --hide-prompt

