#!/bin/bash

USER = $(id -u)

if [ USER -ne 0]

then 
    echo "NOt an root user"

else 
    dnf install mysql -y
fi