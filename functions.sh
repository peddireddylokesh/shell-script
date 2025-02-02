#!/bin/bash
  userid=$(id -u)

validate(){
      if [ $1 -eq 0 ];then
        echo "$2 successfully"
        exit 1
    else
        echo "Error:: $2 failed"
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
    echo "mysql is already..... INSTALLED"
fi


dnf list installed git

if [ $? -ne 0 ];then #not installed
    echo "You have sudo access, installing git"
    dnf install git -y
    validate $? "installing git"
else
    echo "git is already..... INSTALLED"
fi