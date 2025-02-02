#!/bin/bash
userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
validate(){
      if [ $1 -eq 0 ];then
        echo -e "$2 ...$G successfully"
        exit 1
    else
        echo -e "Error:: $2  .....$R failed"
    fi
}
if [ $userid -ne 0 ];then
    echo "Error:: you must have sudo access to execute this script"
fi

dnf list installed mysql


if [ $? -ne 0 ];then #not installed
    echo "You have sudo access, installing mysql"
    dnf install mysql -y
    validate $? "installing mysql"
else
    echo -e "mysql is already..... $Y INSTALLED"
fi


dnf list installed git

if [ $? -ne 0 ];then #not installed
    echo "You have sudo access, installing git"
     validate $? "installing git"
else
    echo -e "git is already..... $Y INSTALLED"
fi