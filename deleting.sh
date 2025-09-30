#!/bin/bash

source_Dir="/home/ec2-user/shell-logs"
log_Store="/home/ec2-user/logged_logs/logs-$(date +'%Y-%m-%d_%H-%M-%S').log"


if [ -d "$source_Dir" ]; 
then
    FILES_TO_DELETE=$(find "$source_Dir" -name "*.log" -mtime +14)
    while read -r file; do
        echo "$file" &>>log_Store
    done <<< "$FILES_TO_DELETE"
fi
