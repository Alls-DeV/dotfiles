#!/bin/sh

case "$(echo -e "Poweroff\nreBoot\nloGout\nlocK" | dmenu \
    -nb "#191724" \
    -nf "#908caa" \
    -sb "#191724" \
    -sf "#9ccfd8" \
    -fn "JetBrains Mono Nerd Font-15" \
    -l 5 -i -p "Power Menu:")" in
        Poweroff) exec systemctl poweroff;;
        reBoot) exec systemctl reboot;;
        loGout) exec i3-msg exit;;
        locK) exec i3lock --image=/home/alls/Pictures/space.png;;
esac
