#!/bin/bash

# functions and colours

userid=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
Log_folder="/var/log/shellscript-logs"
logfile=$(echo $0 | cut -d "." -f 1)
timestamp=$(date '+%d-%m-%Y-%H-%M-%S')
logfilename="$Log_folder/$logfile-$timestamp.log"
validate(){
      if [ $1 -eq 0 ];then
        echo -e "$2 ...$G successfully $N"
        exit 1
    else
        echo -e "Error:: $2  .....$R failed $N"
    fi
}

echo "script started at $timestamp" &>>$logfilename
if [ $userid -ne 0 ];then
    echo "Error:: you must have sudo access to execute this script"
fi

dnf list installed mysql


if [ $? -ne 0 ];then #not installed
    echo "You have sudo access, installing mysql"
    dnf install mysql -y  &>>$logfilename
    validate $? "installing mysql"
else
    echo -e "mysql is already..... $Y INSTALLED $N"
fi


dnf list installed git

if [ $? -ne 0 ];then #not installed
    echo "You have sudo access, installing git"
    dnf install git -y  &>>$logfilename
     validate $? "installing git"
else
    echo -e "git is already..... $Y INSTALLED $N"
fi