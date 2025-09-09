#!/bin/bash

USER_ID=$(id -u)

if [ "$USER_ID" -ne 0 ]; then
    echo "Not a root user"
    exit 1
else
    dnf install mysql -y
fi

if [ $? -eq 0 ]
then 
    dnf install git -y
else
    echo -e $R "Previous installation not done"
    exit 1
fi