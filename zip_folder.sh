#!/bin/bash

source_Dir="/home/ec2-user/shell-logs"
log_Store="/home/ec2-user/logged_logs/logs-$(date +'%Y-%m-%d_%H-%M-%S').log"
DAYS=${1:-14}

if [ -d "$source_Dir" ]; then
    FILES_TO_Zip=$(find "$source_Dir" -name "*.log" -mtime +"$DAYS")
    
    for file in $FILES_TO_Zip; do
        echo "Found: $file" >> "$log_Store"
    done
else
    echo "Directory not found: $source_Dir" >> "$log_Store"
fi
