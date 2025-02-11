#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
dest_dir=$2
days=${3:14} # if user is not provinding the days then it will take 14 days as default

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
usage(){
    echo -e "$R Usage:: $N sh backup.sh <source_dir> <dest_dir> <days(optional)>"
}

mkdir -p $/home/ec2-user/sheell-script-logs/

if [ $# lt 2 ];then
    usage
fi 
echo "script started executing at $timestamp" &>>$logfilename

