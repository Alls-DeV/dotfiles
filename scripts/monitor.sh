#!/bin/bash

LAPTOP="eDP-1"
EXT="HDMI-1"

echo "Select your monitor configuration:"
echo "1) Built-in Monitor"
echo "2) HDMI Monitor"
echo "3) Mirror"
echo "4) Together (Extended Desktop)[bad idea]"

read -p "Enter your choice (1-4): " choice

case "$choice" in
  1)
    # Laptop only, native res + high DPI
    xrandr \
      --output "$EXT" --off \
      --output "$LAPTOP" --primary --mode 2560x1600 --rate 90

    # HiDPI for laptop panel
    xrdb -merge <<< "Xft.dpi: 192"
    export GDK_SCALE=2
    export GDK_DPI_SCALE=1
    export QT_SCALE_FACTOR=2
    ;;

  2)
    # External only, force 3840x2160@60 (max resolution)
    xrandr \
      --output "$LAPTOP" --off \
      --output "$EXT" --primary --mode 3840x2160 --rate 60

    # 4K ~163 DPI → you probably still want scaling
    # Adjust these to taste: 1.5–2 is common on 4K
    xrdb -merge <<< "Xft.dpi: 160"
    export GDK_SCALE=2          # integer scale
    export GDK_DPI_SCALE=0.75   # 2 * 0.75 ≈ 1.5 effective
    export QT_SCALE_FACTOR=1.5
    ;;

  3)
    # Mirror: both screens must share a common mode.
    # This *will not* be pixel-perfect because 2560x1600
    # is not a native mode of the HDMI monitor.
    xrandr \
      --output "$LAPTOP" --auto \
      --output "$EXT" --auto --same-as "$LAPTOP"

    xrdb -merge <<< "Xft.dpi: 120"
    export GDK_SCALE=1
    export GDK_DPI_SCALE=1
    export QT_SCALE_FACTOR=1
    ;;

  4)
    # Extended desktop: different DPI on each monitor is a mess on X11.
    # You’ll always be compromising here.
    xrandr \
      --output "$LAPTOP" --primary --mode 2560x1600 \
      --output "$EXT" --mode 3840x2160 --right-of "$LAPTOP"

    xrdb -merge <<< "Xft.dpi: 160"
    export GDK_SCALE=1
    export GDK_DPI_SCALE=1
    export QT_SCALE_FACTOR=1
    ;;

  *)
    echo "Invalid choice. Please enter a number between 1 and 4."
    ;;
esac

i3-msg restart

