#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 \"<wildcard>\" [directory]"
    exit 1
fi

WILDCARD="$1"  # Wildcard argument enclosed in quotes
DIRECTORY=${2:-.}  # If no directory is given, default to current directory

# Check  directory
if [ ! -d "$DIRECTORY" ]; then
    echo "Error: Directory \"$DIRECTORY\" does not exist."
    exit 1
fi

# Search files in the directory and subdirectories if directory is given
if [ "$#" -eq 2 ]; then
    FILES=$(find "$DIRECTORY" -type f -name "$WILDCARD")
else
    FILES=$(find . -maxdepth 1 -type f -name "$WILDCARD")
fi

# Check if no files found
if [ -z "$FILES" ]; then
    echo "No files found matching the pattern."
    exit 0
fi

# Ask user to confirm deletion for each file
for FILE in $FILES; do
    read -p "Do you want to delete $FILE? (y/n): " RESPONSE
    while [[ "$RESPONSE" != "y" && "$RESPONSE" != "n" ]]; do
        read -p "Invalid input. Please type 'y' or 'n': " RESPONSE
    done

    if [ "$RESPONSE" = "y" ]; then
        rm "$FILE"
        echo "1 file deleted."
    else
        echo "$FILE not deleted"
    fi
done

echo "All files processed."

