#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_dir=$1
dest_dir=$2
days=${3:-14}  # if user is not providing the days then it will take 14 days as default

Log_folder="/home/ec2-user/shellscript-logs"
logfile=$(echo $0 | cut -d "." -f 1)
timestamp=$(date '+%d-%m-%Y-%H-%M-%S')
logfilename="$Log_folder/$logfile-$timestamp.log"

usage(){
    echo -e "$R Usage:: $N sh backup.sh <source_dir> <dest_dir> <days(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/

# Check for sufficient arguments
if [ $# -lt 2 ]; then
    usage
fi 

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo -e "Error:: $source_dir does not exist....please check" &>> $logfilename
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$dest_dir" ]; then
    echo -e "Error:: $dest_dir does not exist....please check" &>> $logfilename
    exit 1
fi

echo "Script started executing at $timestamp" &>> $logfilename
find "$source_dir" -name "*.log" -mtime +$days | while read -r file_path; do
    echo "File found: $file_path" &>> $logfilename
    files+=("$file_path")
done



# Check if zip is installed, if not install it
if ! command -v zip &> /dev/null; then
    echo -e "zip command is not found, installing zip..." &>> $logfilename
    if [ -f /etc/debian_version ]; then
        # For Debian/Ubuntu-based systems
        sudo apt-get update && sudo apt-get install -y zip
    elif [ -f /etc/redhat-release ]; then
        # For Red Hat/CentOS/Fedora-based systems
        sudo yum install -y zip
    else
        echo "Error: Unsupported OS. Please install zip manually." &>> $logfilename
        exit 1
    fi

    # Check if zip is installed successfully
    if ! command -v zip &> /dev/null; then
        echo "Error: Failed to install zip. Exiting script." &>> $logfilename
        exit 1
    fi

    echo -e "zip command is now installed." &>> $logfilename
fi

# If log files are found, zip them
if [ {"$files[@]"} -gt 0]; then

    echo "Files found: $files" &>> $logfilename
    zip_file="$dest_dir/app-logs-$timestamp.zip"
    find "$source_dir" -name "*.log" -mtime +$days | zip -@ "$zip_file"

    if [ -f "$zip_file" ]; then
        echo -e "Zipped file is successfully created for files older than $days days." &>> $logfilename

        # Delete the old log files after zipping
        while read -r file_path; do
            echo "Deleting $file_path" &>> $logfilename
            rm -rf "$file_path"
            echo "Deleted file: $file_path" &>> $logfilename
        done <<< "$files"
    else
        echo -e "$R Error:: $N Failed to create the zip file" &>> $logfilename
        exit 1
    fi
else
    echo -e "$R No files found older than $days days $N" &>> $logfilename
    exit 1
fi

