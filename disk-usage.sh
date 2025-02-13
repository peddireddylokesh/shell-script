#!/bin/bash

disk_usage=$(df -hT | grep xfs)
disk_threshhold=5 #in real projects it would
while read -r line
do 
   
    usage=$(echo $line | awk  -F " " '{print $6F}' | cut -d "%" -f1)
    partition=$(echo $line | awk  -F " " '{print $6F}')
   # echo "partition  is $partition ,usage : $usage"
    if [ $usage -ge $disk_threshhold ]
    then
        msg+="Disk usage is high  $partition usage is $usage \n"
    fi
done <<< $disk_usage

echo -e "message $msg"

