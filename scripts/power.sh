#!/bin/sh

# -    bindsym l exec --no-startup-id dm-tool lock, mode "default"
case "$(echo -e "Shutdown\nRestart\nLogout\nLock" | dmenu \
    -nb "#191724" \
    -nf "#908caa" \
    -sb "#191724" \
    -sf "#9ccfd8" \
    -fn "JetBrains Mono Nerd Font-15" \
    -l 5 -i -p "Power Menu:")" in
        Shutdown) exec systemctl poweroff;;
        Restart) exec systemctl reboot;;
        Logout) exec i3-msg exit;;
        Lock) exec i3lock --image=/home/alls/Pictures/space.png;;
esac
