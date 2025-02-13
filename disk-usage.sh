#!/bin/bash

disk_usage=$(df -hT | grep xfs)
while read -r line
do 
    echo "$line"
done <<<$disk_usage