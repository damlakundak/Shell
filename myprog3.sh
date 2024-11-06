#!/bin/bash

# Creates the writable directory
mkdir -p writable

# The number of moved files is initially 0
movedFile=0 

# Checks all the files in the current directory
for file in *
do
    if [ -f "$file" ]
    then
        # Checks the file has write permission or not
        if [ -w "$file" ]
        then
            # Moves the file to the writable directory
            mv "$file" writable/ 2>/dev/null 
            if [ $? -eq 0 ]
            then                  
            ((movedFile++))                  
            fi
        fi
    fi
done

echo "$movedFile files moved to writable directory."
