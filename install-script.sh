#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error you must have sudo access to execute this script"
elif [ $USERID -eq 0 ]; then
    echo "You have sudo access"
    dnf install mysql -y
fi
