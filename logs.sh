#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

log_folder="/var/log/shell-scriptinglogs"   # Fixed: Added missing leading slash
log_file_name="$(basename $0 | cut -d '.' -f1)-$(date +%y-%m-%d).log"
log_file_path="$log_folder/$log_file_name"

# Create log folder if it doesn't exist
mkdir -p "$log_folder"

# Logging function
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE" | tee -a "$log_file_path"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS" | tee -a "$log_file_path"
    fi
}

# Check for root user
if [ "$USERID" -ne 0 ]; then
    echo -e "${R}You must be root to run this script" | tee -a "$log_file_path"
    exit 1
fi

# Loop through input packages
for package in "$@"; do
    dnf list installed "$package" &>>"$log_file_path"
    if [ $? -ne 0 ]; then
        dnf install "$package" -y &>>"$log_file_path"
        VALIDATE $? "Installing $package"
    else 
        echo -e "$Y$package is already installed: $(date +%y-%m-%d %H:%M:%S)" | tee -a "$log_file_path"
    fi
done
