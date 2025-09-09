#!/bin/bash
R=$(\e[31m)
B=$(\e[32m)
USER_ID=$(id -u)


if [ $USER_ID -ne 0 ]
then
    echo -e $R "Not a root user"
else
    dnf install mysql -y 
fi

# if[ $? -eq 0 ]
# then
#     Validate $USER_ID
#     dnf install git -y 
#     echo -e $R "installed successfull"
# else
#     echo -e $B "Previous installation not done"
# fi

