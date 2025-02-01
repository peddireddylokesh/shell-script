#!/bin/bash
person1=$1 #no spaces should put between before and after the equal
person2=$2

echo "$person1::hi $person2"    #output: loki::hi thor
echo "$person2::hello $person1"
echo "$person1::how are you doing"
echo "$person2::i am doing good"
echo "$person1::i am also doing good"
echo "$person2::i am happy to hear that"