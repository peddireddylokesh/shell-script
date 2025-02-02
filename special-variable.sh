#!/bin/bash
#imp interview questions
echo "all variables passed: $@"
echo "number of variables passed: $#"
echo "script name: $0"
echo "present working directory: $PWD"
echo "last command status: $?"
echo "home directory of current user: $HOME"
echo "current user: $USER"
echo "process id of current shell-script: $$"
sleep 10 &
echo "last background process id: $!"