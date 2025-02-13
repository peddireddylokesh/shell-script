#!/bin/bash

disk_usage=$(df -hT | grep xfs)
disk_threshhold=5 #in real projects it would
while read -r line
do 
   
    echo "$line"
    usage=$(echo $line | awk  -F " "'{print $6F}')
    partition=$(echo $line | awk  -F " "'{print $6F}')
    echo "partition  is $partition" $usage 
done <<<$disk_usage