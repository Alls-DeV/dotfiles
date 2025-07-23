#!/bin/bash

# Find all .jpg files in the directory and select one at random
wallpaper=$(find ~/Pictures/Wallpapers -type f -name "*.jpg" | shuf -n 1)

# Set the background using feh
feh --bg-scale "$wallpaper"
