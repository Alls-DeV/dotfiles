#!/bin/bash

echo "Select your monitor configuration:"
echo "1) Built-in Monitor"
echo "2) HDMI Monitor"
echo "3) Mirror"
echo "4) Together (Extended Desktop)[bad idea]"

read -p "Enter your choice (1-4): " choice

case $choice in
	1)
		xrandr --output HDMI-1 --off
		xrandr --output eDP-1 --auto
		export GDK_SCALE=2
		export GDK_DPI_SCALE=0.5
		export QT_SCALE_FACTOR=2
		xrdb -merge <(echo "Xft.dpi: 192")
		;;
	2)
		xrandr --output eDP-1 --off
		xrandr --output HDMI-1 --auto
		export GDK_SCALE=1
		export GDK_DPI_SCALE=1
		export QT_SCALE_FACTOR=1
		xrdb -merge <(echo "Xft.dpi: 96")
		;;
	3)
		xrandr --output eDP-1 --auto --output HDMI-1 --auto --same-as eDP-1
		export GDK_SCALE=1
		export GDK_DPI_SCALE=1
		export QT_SCALE_FACTOR=1
		xrdb -merge <(echo "Xft.dpi: 96")
		;;
	4)
		xrandr --output eDP-1 --auto --output HDMI-1 --auto --right-of eDP-1
		export GDK_SCALE=1
		export GDK_DPI_SCALE=1
		export QT_SCALE_FACTOR=1
		xrdb -merge <(echo "Xft.dpi: 96")
		;;
	*)
		echo "Invalid choice. Please enter a number between 1 and 4."
		;;
esac
i3-msg restart
