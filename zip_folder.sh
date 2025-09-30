#!/bin/bash
source_Dir="/home/ec2-user/shell-logs"
log_Store="/home/ec2-user/logged_logs/logs-$(date +'%Y-%m-%d_%H-%M-%S').log"
DAYS=${1:-14}

if [ -d "$source_Dir" ]; then
    FILES_TO_Zip=$(find "$source_Dir" -name "*.log" -mtime +"$DAYS")
    if [ -n "$FILES_TO_Zip" ]
    then   
        echo "these are files to ZIP : $FILES_TO_Zip" &>>log_Store
    else
        echo "no files to zip" &>>log_Store
    fi
fi
