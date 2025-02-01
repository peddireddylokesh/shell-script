#!/bin/bash
    #array declaration

MOVIES=("Pushpa" "rrr" "salar")

echo "first movie is  : ${MOVIES[0]}"
echo "second movie is : ${MOVIES[1]}"
echo "third movie is  : ${MOVIES[2]}"

echo "All movies are  : ${MOVIES[@]}"