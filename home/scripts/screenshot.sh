#!/bin/sh

sleep_time=5

if [ $# -ne 1 ]; then
    echo "Usage: $0 <time>"
    exit 1
else
    sleep_time="$1"
fi

sleep "$1" && grim -g "$(slurp)"