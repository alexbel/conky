#!/bin/bash
result=$()
if [ "$2" = "proto" ]
then
   netstat -np 2>/dev/null | grep ESTABLISHED | awk -v num=$1 'NR==num{print $1}' | sort -u
fi

if [ "$2" = "address" ]
then
   netstat -np 2>/dev/null | grep ESTABLISHED | awk -v num=$1 'NR==num{print $5}' | sort -u
fi

if [ "$2" = "name" ]
then
   netstat -np 2>/dev/null | grep ESTABLISHED | awk -v num=$1 'NR==num{print $7}' | sort -u | sed "s/\// /g" | awk '{print $2}'
fi
