#!/bin/bash

caps=$(cat /sys/class/power_supply/BAT*/capacity)

sum=0
batts=0
for cap in $caps; do
    sum=$(($sum + $cap))
    batts=$(($batts + 1))
done
avg=$(($sum / $batts))

echo "{\"percentage\": $avg}"
