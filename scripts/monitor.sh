#!/bin/bash

echo "Select your monitor configuration:"
echo "1) Built-in Monitor"
echo "2) HDMI Monitor"
echo "3) Mirror"
echo "4) Together (Extended Desktop)"

read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        xrandr --output HDMI-A-0 --off
        xrandr --output eDP --auto
        ;;
    2)
        xrandr --output eDP --off
        xrandr --output HDMI-A-0 --auto
        ;;
    3)
        xrandr --output eDP --auto --output HDMI-A-0 --auto --same-as eDP
        ;;
    4)
        xrandr --output eDP --auto --output HDMI-A-0 --auto --right-of eDP
        ;;
    *)
        echo "Invalid choice. Please enter a number between 1 and 4."
        ;;
esac
