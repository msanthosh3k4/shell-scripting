#!/bin/bash

source_Dir="home/ec2-user/shell-logs"


if [ -d $source_Dir ]
then
    while read -r files
    do
        echo $files
    done < source_Dir
fi
        