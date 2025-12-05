#!/usr/bin/env bash

lock=" locK"
logout=" loGout"
reboot=" reBoot"
shutdown=" Poweroff"
 
selected_option=$(echo "$lock
$logout
$reboot
$shutdown" | rofi -dmenu -i)

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
