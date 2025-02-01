#!/bin/bash
num=$1

#-gt is a greater than operator 
#-p is a prompt operator
#-lt is a less than operator
#-eq is a equal to operator
#-ne is a not equal to operator
#-le is a less than or equal to operator
#-ge is a greater than or equal to operator
read -p "please enter a number : " num
if [ $num -gt 100 ]
then
    echo "given number is  greater than 100"
elif [ $num -lt 100 ]
then
    echo "given number is less than 100"
else
    echo "given number is equal to 100"
fi
