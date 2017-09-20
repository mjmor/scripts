#!/bin/bash

# Author: Maxwell Morgan <mjmor@umich.edu>

INCREMENT=300

curr_val=`sudo cat /sys/class/backlight/intel_backlight/brightness`
max_val=`sudo cat /sys/class/backlight/intel_backlight/max_brightness`
min_val=0

if [[ $1 == "up" ]]; then
    new_val=`expr $curr_val + $INCREMENT`
    if [ $new_val -gt $max_val ]; then
        new_val=$max_val
    fi
    sudo tee /sys/class/backlight/intel_backlight/brightness <<< $new_val
elif [ $1 == "down" ]; then
    new_val=`expr $curr_val - $INCREMENT`
    if [ $new_val -lt $min_val ]; then
        new_val=$min_val
    fi
    sudo tee /sys/class/backlight/intel_backlight/brightness <<< $new_val
fi
