#!/bin/bash
#-- tests
#./level8.sh Arena "Low health"
#./level8.sh Arena ERROR
#./level8.sh Arena "not here"
#--
DIRECTORY=$1
WORD=$2

if [ ! -d "$DIRECTORY" ]; then
    echo "directory '$DIRECTORY' does not exist"
    exit 1
fi

# find in DIRECTORY
# a file
# where the filename contains .log
# execute grep for each file
#, -l prints file name if the WORD is found
#, {} adds the filename found during find
#, + marks the end of the grep command 
find "$DIRECTORY" -type f -name "*.log" -exec grep -l "$WORD" {} +