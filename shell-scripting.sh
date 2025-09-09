#!/bin/bash

number=$1

if [ "$number" -ne 10 ]; 
then
    echo "This number is not equal to 10"
else
    echo "Yes, your selected number is equal to 10"
fi