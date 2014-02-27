#!/bin/bash

total=`cat /proc/acpi/battery/BAT0/info | grep "last full capacity:" | awk '{print $4}'`
rate=`cat /proc/acpi/battery/BAT0/state | grep "rate" | awk '{print $3}'`

if [ $rate -eq  0 ]; then
    echo '0 mW'
  else
    minutes=`echo "$rate / $total * 100 / 60" | bc -l`
    result=$(printf "%1.2f" $minutes)
    echo "$result % per minute"
fi
