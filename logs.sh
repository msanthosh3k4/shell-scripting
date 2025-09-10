
#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
Time_Stamp=$(date)
logFile="shell-scripting/logs.txt"

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS"
    fi
}

if [ "$USERID" -ne 0 ]; then
    echo -e "${R}You must be root to run this script"
    exit 1
fi

for package in "$@"; do
    dnf list installed "$package" 
    if [ $? -ne 0 ]; then
        dnf install $package -y 
        VALIDATE $? "Installing $package" &>>logFile
    else 
        echo -e "$Y$package is already installed:$Time_Stamp" &>>logFile
    fi
done



