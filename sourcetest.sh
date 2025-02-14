#!/bin/bash
source ./common.sh

source_dir="/home/ec2-user/app-logs"

echo "script started executing at $timestamp" &>>$logfilename

files_to_delete=$(find $source_dir -name "*.log" -mtime +7)
echo "files to be deleted: $files_to_delete"

while read -r file_to_do
do
    echo "deleting $file_to_do"
    rm -rf $file_to_do
done <<< $files_to_delete