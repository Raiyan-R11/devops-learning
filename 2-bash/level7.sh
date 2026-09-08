#!/bin/bash

if  [ ! -d "$1" ]; then
    echo "directory '$1' does not exist."
    exit 1
fi

find "$1" -type f -name "*.txt" -exec ls -lh {} + |
sort -k 5,5 -h |
awk '{ print $5, $9 }'