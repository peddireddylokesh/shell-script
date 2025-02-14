#!/bin/bash

disk_usage=$(df -hT | grep xfs) # Extract only xfs filesystem lines
disk_threshhold=5  # Define threshold (in percentage)
msg=""

while read -r line
do 
   
    usage=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
    partition=$(echo $line | awk  -F " " '{print $6F}')
   # echo "partition  is $partition ,usage : $usage"
    if [ $usage -ge $disk_threshhold ]
    then
        msg+="Disk usage is high: $partition usage is $usage /n "
    fi
done <<< $disk_usage

echo -e "message :: $msg"

echo $msg "Subject: high disk usage" | sendmail manoharpanthala345@gmail.com


