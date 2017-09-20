#!/bin/bash

source mk_var_dir.sh

mon_var_file=${var_dir}/display_vars

if ! [ -f $mon_var_file ]; then
    echo "EXTERN_ON=true" > $mon_var_file
fi

source $mon_var_file

l_or_r="$1"

if [ "$l_or_r" != "left" ] && [ "$l_or_r" != "right" ] && \
    [ "$l_or_r" != "dup" ]; then
    echo "Must specify which side monitor is on...";
    echo "Usage: ./toggle_mon.sh [left|right]";
    exit 1;
fi

intern=LVDS1
extern=HDMI1

if ! $EXTERN_ON && xrandr | grep -q "${extern} disconnected"; then
    echo "Cannot attach monitor, no monitor found..."
    exit 1
elif ! $EXTERN_ON && xrandr | grep -q "${extern} connected" && [ "$l_or_r" == "dup" ]; then
    echo "Attaching duplicate monitor..."
    xrandr --output "$intern" --primary --auto --output \
        "$extern" --auto
    echo "EXTERN_ON=true" > $mon_var_file
elif ! $EXTERN_ON && xrandr | grep -q "${extern} connected"; then
    echo "Attaching monitor..."
    xrandr --output "$intern" --primary --auto --output \
        "$extern" --${l_or_r}-of "$intern" --auto
    echo "EXTERN_ON=true" > $mon_var_file
else
    echo "Detaching monitor..."
    xrandr --output "$intern" --auto --output "$extern" --off
    echo "EXTERN_ON=false" > $mon_var_file
fi
