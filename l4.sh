#!/bin/bash
echo "please enter your user name" # text entered here will be added as a value or variable
read -s USERNAME # it is a variable name
echo "username is $USERNAME"
echo "please enter your password"
read -s PASSWORD  #if we add -s before username to reading format like [ read -s USERNAME ] no one can see the typing or cursor
