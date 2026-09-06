#!/bin/bash

mkdir -p Arena_Boss
rm -f Arena_Boss/file{1..5}.txt
rm -f Victory_Archive/*.txt

for i in {1..5}; do 
    count=$((RANDOM % 11 + 10))
    
    for ((line = 1; line <= count; line++)); do
        if (( RANDOM % 7 == 0 )); then
            echo "Victory" >> "Arena_Boss/file$i.txt"
        else
            echo "Line $line" >> "Arena_Boss/file$i.txt"
        fi
    done
done

echo ".txt files in Area_Boss directory sorted by size: "
find Arena_Boss -type f -name "*.txt" -exec ls -lh {} + | sort -k 5,5 -h | awk '{ print $5, $9 }'

mkdir -p Victory_Archive

echo "files containing the word 'Victory' moved to Victory_Archive directory!"
find Arena_Boss -type f -name "*.txt" -print0 |
while IFS= read -rd '' file; do
    if grep -q "Victory" "$file"; then
        mv "$file" Victory_Archive/
    fi
done
# find ... -print0 -> seperates filenames by null char
# IFS -> clears Bash Internal Field Seperator, so whitespace in filenames are preserved
# read -rd -> -r: do not treat \ as escape, -d: read stops at null char
# grep -q -> quite mode, no output, only success/failure status
