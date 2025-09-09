#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS"
    fi
}

for packeges in $@
do
    dnf list installed $package
    if[ $? -ne 0 ]
    then
        dnf install $package
        VALIDATE $? "Installing"
    else 
        echo "package is already installed"
        exit 1 #other than 0
    fi
done


#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

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
        VALIDATE $? "Installing $package"
    else 
        echo -e "$Y$package is already installed"
    fi
done

# if [ $USERID -eq 0 ]
# then
#     dnf list installed git
# else 
#     echo "ERROR:: You must have sudo access to execute this script"
#     exit 1 #other than 0
# fi

# # dnf list installed git

# if [ $? -ne 0 ]
# then
#     dnf install git -y
#     VALIDATE $? "Installing Git"
# else
#     echo -e "Git is already ... $Y INSTALLED"
# fi

# dnf list installed mysql

# if [ $? -ne 0 ]
# then # not installed
#     dnf install mysql -y
#     VALIDATE $? "Installing MySQL"
# else
#     echo -e "MySQL is already ... $Y INSTALLED"
# fi


