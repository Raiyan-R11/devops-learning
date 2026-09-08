#!/bin/bash

# check if $1 length is zero
if [ -z "$1" ]; then 
    echo "no directory provided!"
    exit 1
elif [ ! -d "$1" ]; then 
    echo "directory does not exist!"
    exit 1
fi

if [ -z "$2" ]; then 
    echo "no max usage threshold provided!"
    exit 1
fi

DIRECTORY="$1"
THRESHOLD="$2"
USAGE="$(du -sm "$DIRECTORY" | awk '{print $1}')"

if (( USAGE > THRESHOLD )); then
    echo "WARNING: disk usage for DIRECTORY $DIRECTORY exceeded threshold [ $USAGE >= $THRESHOLD ]"
else
    echo "OK: disk usage for DIRECTORY $DIRECTORY is at $USAGE"
fi

