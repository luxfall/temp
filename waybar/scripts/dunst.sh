#!/bin/bash

ENABLED=󰂚
if [ $(dunstctl count waiting) != 0 ]; then
        ENABLED=󱅫
fi

CLASS=""
if dunstctl is-paused | grep -q "tru" ; then
        CLASS=inactive
fi

echo "{ \"text\": \"$ENABLED\", \"class\": \"$CLASS\" }"

