#!/bin/bash
num1=$1
num2=$2

timestamp=$(date)
echo "timestamp is $timestamp"
sum = $(($num1 + $num2))
echo "sum of num1 + num2 is : $sum"
