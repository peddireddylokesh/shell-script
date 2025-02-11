#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
dest_dir=$2
days=${3:-14} # if user is not provinding the days then it will take 14 days as default

Log_folder="/home/ec2-user/shellscript-logs"
logfile=$(echo $0 | cut -d "." -f 1)
timestamp=$(date '+%d-%m-%Y-%H-%M-%S')
logfilename="$Log_folder/$logfile-$timestamp.log"

validate(){
      if [ $1 -eq 0 ];then
        echo -e "$2 ...$G successfully $N"

    else
        echo -e "Error:: $2  .....$R failed $N"
        exit 1
    fi
}
usage(){
    echo -e "$R Usage:: $N sh backup.sh <source_dir> <dest_dir> <days(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/

if [ $# -lt 2 ];then
    usage
fi 
echo "script started executing at $timestamp" &>>$logfilename

if [ ! -d $source_dir ];then
    echo -e "Error:: $source_dir does not exists....please check"
    exit 1
fi
if [ ! -d $dest_dir ];then
    echo -e "Error:: $dest_dir does not exists....please check"
    exit 1
fi

files=$(find "$source_dir" -name "*.log" -mtime +$days)
if [ -n "$files" ];then
    echo "files are: $files"
else
    echo "No files found olderthan $days"
    exit 1
fi
