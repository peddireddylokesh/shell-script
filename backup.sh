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

usage(){
    echo -e "$R Usage:: $N sh backup.sh <source_dir> <dest_dir> <days(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/

if [ $# -lt 2 ];then
    usage
fi 

if [ ! -d $source_dir ];then
    echo -e "Error:: $source_dir does not exists....please check"
    exit 1
fi
if [ ! -d $dest_dir ];then
    echo -e "Error:: $dest_dir does not exists....please check"
    exit 1
fi

echo "script started executing at $timestamp" &>>$logfilename

# Find .log files older than the specified number of days
files=$(find "$source_dir" -name "*.log" -mtime +$days)

# Check if zip is installed, if not install it
if ! command -v zip &> /dev/null then
    echo -e "zip command is not found, installing zip" &>>$logfilename
 if [ -f /etc/debian_version ]; then
        # For Debian/Ubuntu-based systems
        sudo apt-get update && sudo apt-get install -y zip
    elif [ -f /etc/redhat-release ]; then
        # For Red Hat/CentOS/Fedora-based systems
        sudo yum install -y zip
    else
        echo "Error: Unsupported OS. Please install zip manually."
        exit 1
    fi
 if ! command -v zip &> /dev/null then
        echo "Error: Failed to install zip. Please install zip manually."
        exit 1
    fi

    echo -e "zip command is now installed" &>>$logfilename
fi

if [ -n "$files" ];then   # true if they are files to zip
    echo "files are: $files"
    zip_file="$dest_dir/app-logs-$timestamp.zip" 
    find $source_dir -name "*.log" -mtime +$days | zip -@ "$zip_file"
    if [ -f $zip_file ];then
     echo -e "zipped file is successfully created older-than $days" &>>$logfilename

        while read -r file_path
        do
            echo "deleting $file_path" &>>$logfilename
            rm -rf $file_path
            echo  "Deleted file : $file_path"
        done <<< $files
    else
        echo -e "Error:: $N failed to create zip file" &>>$logfilename
        exit 1
    fi
else
    echo -e "$R No files found $N olderthan  $days" &>>$logfilename
    exit 1
fi
