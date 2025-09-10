
#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

log_folder="/var/logs/shell-scriptinglogs"
log_file_name="$(basename $0 | cut -d '.' -f1)-$(date +%y-%m-%d).log"
log_file_path="$log_folder/$log_file_name"

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS"
    fi
}

if [ "$USERID" -ne 0 ]; then
    echo -e "${R}You must be root to run this script" &>>log-file-name
    exit 1
fi

for package in "$@"; do
    dnf list installed "$package" &>>log-file-name
    if [ $? -ne 0 ]; then
        dnf install $package -y 
        VALIDATE $? "Installing $package" &>>log-file-name 
    else 
        echo -e "$Y$package is already installed:$Time_Stamp" &>>log-file-name 
    fi
done



