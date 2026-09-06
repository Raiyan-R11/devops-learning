#!/bin/bash

CONFIG_FILE="$1"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: file does not exist in the current directory"
    exit 1
fi

# IFS='=' tells read to split each line at =
while IFS='=' read -r key value; do
    echo "Key: $key, Value: $value"
done < "$CONFIG_FILE"