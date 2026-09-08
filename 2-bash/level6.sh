#!/bin/bash

if [ -z "$1" ]; then
    echo "No filename provided"
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "file does not exist."
    exit 1
fi

echo "The file '$1' contains $(wc -l < "$1") lines"
