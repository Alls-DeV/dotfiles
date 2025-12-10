#!/usr/bin/env bash

shutdown=" Poweroff"
reboot=" reBoot"
lock=" locK"
logout=" loGout"
 
selected_option=$(echo "$shutdown
$reboot
$lock
$logout" | rofi -dmenu -i)

if [ "$selected_option" == "$lock" ]
then
    swaylock -f -c 000000
elif [ "$selected_option" == "$logout" ]
then
    loginctl terminate-user `whoami`
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
else
    echo "No match"
fi
