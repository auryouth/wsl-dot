#!/bin/bash

if [ "$1" = up ];then
    light -A 0.5 -s sysfs/backlight/nvidia_wmi_ec_backlight && light -A 0.5
fi

if [ "$1" = down ];then
    light -U 0.5 -s sysfs/backlight/nvidia_wmi_ec_backlight && light -U 0.5
fi
