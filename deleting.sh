#!/bin/bash

source_Dir="/home/ec2-user/shell-logs"

if [ -d "$source_Dir" ]; 
then
    FILES_TO_DELETE=$(find "$source_Dir" -name "*.log" -mtime +14)
    while read -r file; do
        echo "$file"
    done <<< "$FILES_TO_DELETE"
fi
