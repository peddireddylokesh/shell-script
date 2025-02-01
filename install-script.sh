#!/bin/bash

USERID=$(id -u)
    read -p "Do you want to install mysql [y/n] : " input

if [ $USERID -ne 0 ]; then
    echo "Error you must have sudo access to execute this script"
elif [ $USERID -eq 0 ]; then
    echo "You have sudo access"
    dnf install mysql -y
elif [ $USERID -eq 1 ]; then
    echo "you have entered 1 so im uninstalling mysql with dependencies too"
    sudo dnf remove mysql-server -y
    sudo dnf autoremove -y
    sudo systemctl status mysqld
    rpm -qa | grep mysql
fi
