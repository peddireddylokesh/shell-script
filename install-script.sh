#!/bin/bash
userid=$(id -u)
#     read -p "Do you want to install mysql [y/n] : " input

# if [ $input == "y" ]; then
   
#     if [ $USERID -ne 0 ]; then
#         echo "Error:: you must have sudo access to execute this script"
#     else
#         echo "You have sudo access, installing mysql"
#         dnf install mysql -y
#     fi
# elif [ $input == "n" ]; then
#     if [ $USERID -ne 0 ]; then
#         echo "You must have sudo access to uninstall mysql"
#     else
#         echo "You have sudo access, uninstalling mysql"
#         sudo dnf remove mysql -y
#     fi
# else
#     echo "Invalid input"
# fi

if [ $userid -ne 0 ];then
    echo "Error:: you must have sudo access to execute this script"
fi
dnf list installed mysql
if [ $? -ne 0 ];then #not installed
    echo "You have sudo access, installing mysql"
    dnf install mysql -y
    if [ $? -eq 0 ];then
        echo "mysql installed successfully"
    else
        echo "Error:: mysql installation failed"
    fi
else
    echo "mysql is already..... INSTALLED"
fi