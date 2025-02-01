#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error you must have sudo access to execute this script"
fi
dnf install mysql -y