#!/bin/bash

DIRECTORY=$1

if [ -z "$DIRECTORY" ] || [ ! -d "$DIRECTORY" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi


# Convert the directory to an absolute path and store the log outside it.
DIRECTORY=$(cd "$DIRECTORY" && pwd)
LOG_FILE="$(dirname "$DIRECTORY")/level9_logs.txt"
touch "$LOG_FILE"


fswatch -x -r "$DIRECTORY" | while IFS= read -r event; do
    case "$event" in
        *Created*) action="CREATED" ;;
        *Updated*) action="MODIFIED" ;;
        *Removed*) action="DELETED" ;;
        *) action="CHANGED" ;;
    esac

    printf '%s | %s | %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$action" "$event" >> "$LOG_FILE"
done
