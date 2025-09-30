#!/bin/bash

# Colors for messages
R="\e[31m"  # Red
G="\e[32m"  # Green
Y="\e[33m"  # Yellow
N="\e[0m"   # Reset

# Get arguments
source_Dir="$1"
log_Dir="$2"
DAYS="${3:-14}"

# Check usage
if [ $# -lt 2 ]; then
    echo -e "${R}USAGE:${N} sh zip_folder.sh <SOURCE_DIR> <DEST_DIR> <DAYS (Optional, default=14)>"
    exit 1
fi

# Validate source and destination directories
if [ ! -d "$source_Dir" ]; then
    echo -e "${R}Error:${N} Source directory $source_Dir does not exist."
    exit 1
fi

if [ ! -d "$log_Dir" ]; then
    echo -e "${Y}Info:${N} Destination directory $log_Dir does not exist. Creating it..."
    mkdir -p "$log_Dir"
fi

# Log file
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
log_Store="$log_Dir/logs-$TIMESTAMP.log"
zip_file="$log_Dir/logs-archive-$TIMESTAMP.zip"

echo "Script started at $(date)" >> "$log_Store"
echo "Searching in: $source_Dir for *.log files older than $DAYS days" >> "$log_Store"

# Find the files
FILES=$(find "$source_Dir" -name "*.log" -mtime +"$DAYS")

# Check if files were found
if [ -z "$FILES" ]; then
    echo "No log files older than $DAYS days found." >> "$log_Store"
else
    echo "$FILES" | zip -@ "$zip_file" >> "$log_Store" 2>&1

    # Check if ZIP file was created and is not empty
    if [ -f "$zip_file" ] && [ -s "$zip_file" ]; then
        echo -e "${G}Success:${N} Created ZIP file: $zip_file"
        echo "Zipped files to: $zip_file" >> "$log_Store"

        # Delete the original files
        echo "$FILES" | while read -r filepath; do
            echo "Deleting file: $filepath" >> "$log_Store"
            rm -f "$filepath"
            echo "Deleted file: $filepath" >> "$log_Store"
        done
    else
        echo -e "${R}Error:${N} Failed to create ZIP file or ZIP is empty." | tee -a "$log_Store"
        exit 1
    fi
fi

echo "Script ended at $(date)" >> "$log_Store"
