#!/bin/sh

case "$(echo -e "Poweroff\nreBoot\nloGout\nlocK" | dmenu \
    -nb "#00141a" \
    -nf "#586E75" \
    -sb "#00141a" \
    -sf "#2AA198" \
    -fn "JetBrains Mono Nerd Font-15" \
    -l 5 -i -p "Power Menu:")" in
        Poweroff) exec systemctl poweroff;;
        reBoot) exec systemctl reboot;;
        loGout) exec i3-msg exit;;
        locK) exec i3lock --image=/home/alls/Pictures/space.png;;
esac
