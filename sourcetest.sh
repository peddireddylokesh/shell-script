#!/bin/bash

source ./common.sh

source_dir="/home/ec2-user/app-logs"
logfilename="/var/log/script.log"  # Define your log file

echo "Script started executing at $(date)" &>> "$logfilename"

# Find .log files older than 7 days
files_to_delete=$(find "$source_dir" -name "*.log" -mtime +7)

# Check if any files exist before proceeding
if [ -z "$files_to_delete" ]; then
    echo "No log files older than 7 days found. Exiting..." &>> "$logfilename"
    exit 0
fi

echo "Files to be deleted:" &>> "$logfilename"
echo "$files_to_delete" &>> "$logfilename"

# Safely delete files
while IFS= read -r file_to_delete; do
    echo "Deleting: $file_to_delete" &>> "$logfilename"
    rm -f "$file_to_delete"
done <<< "$files_to_delete"

echo "Log cleanup completed successfully." &>> "$logfilename"
