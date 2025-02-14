#!/bin/bash
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