#!/bin/bash

USER_ID=$(id -u)

if [ "$USER_ID" -ne 0 ]; then
    echo "Not a root user"
else
    dnf install mysql -y
fi

if [ $? -e 0]
then 
    dnf install git -y
else
    "Previous not dome "
    exit 1
fi