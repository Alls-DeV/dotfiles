if [ "$(tty)" = "/dev/tty1" ]; then
    export SDL_VIDEODRIVER=wayland
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    exec sway
fi
