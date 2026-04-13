# My environment setup

This repo contains my dotfile configuration. I use GNU/Linux via the [EndeavourOS distribution](https://endeavouros.com).

## Installing Programs

When I install the OS with EndeavourOS installation, I select no desktop environment but check the 

```bash
sudo pacman -Syu sway foot neovim brightnessctl rofi zsh dunst pipewire pipewire-audio pipewire-alsa pipewire-pulse wireplumber pavucontrol blueman otf-font-awesome ttf-recursive-nerd vlc nemo wl-clipboard wl-clip-persist grim slurp satty unzip wget base-devel curl bat eza man-db git stow swayidle swaybg polkit-gnome cronie tmux
yay google-chrome swaylock-effects-git
```

I manage the various configuration files in this repo using [GNU Stow](https://www.gnu.org/software/stow/).  This allows me to set up symlinks for all of my dotfiles using a single command:

```bash
stow .
```

The inspiration for this configuration comes from [this video](https://www.youtube.com/watch?v=y6XCebnB9gs).


## Systemctl Privileges

```bash
sudo nvim /etc/sudoers.d/sysctl
alls ALL = NOPASSWD: /bin/systemctl
```

## Zsh Configuration
To set zsh as the default shell, run the following command:
```bash
chsh -s $(which zsh)
```

## Oh-my-posh
- https://ohmyposh.dev/docs/installation/linux

## Notification of low battery
1. Make sure che script is executable.

2. Enable and start the cronie service:
```bash
sudo systemctl enable cronie
sudo systemctl start cronie
```
3. Open the crontab file:
```bash
crontab -e
```
4. Append the following line to the crontab file:
```bash
* * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) /home/alls/scripts/batwarn.sh
```

## VSCode and Chrome
Install VSCode and Chrome using yay:
- [VSCode](https://aur.archlinux.org/packages/visual-studio-code-bin)
- [Chrome](https://aur.archlinux.org/packages/google-chrome)

## Browser Extensions
Browser extensions:

- [Adblock Plus](https://chromewebstore.google.com/detail/adblock-plus-free-ad-bloc/cfhdojbkjhnklbpkdaibdccddilifddb)
- [Dark Reader](https://chromewebstore.google.com/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh)
- [DeepL Translate](https://chromewebstore.google.com/detail/deepl-translate/cofdbpoegempjloogbagkncekinflcnj)
- [Video Speed Controller](https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk)
- [Rearrange Tabs](https://chrome.google.com/webstore/detail/rearrange-tabs/ccnnhhnmpoffieppjjkhdakcoejcpbga)

## System, Icon, and Cursor Theme
- unzip into `~/.themes` or `~/.icons` the themes downloaded from http://gnome-look.org or http://xfce-look.org and choose them from lxappearance
- [Phinger Cursors](https://github.com/phisch/phinger-cursors)
- [Rose-pine cursors](https://github.com/rose-pine/cursor)

## Enable 'Open in Terminal' in the file explorer
```bash
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
gsettings set org.cinnamon.desktop.default-applications.terminal exec 'alacritty'
```

## Huion tablet
- [arch wiki](https://wiki.archlinux.org/title/Graphics_tablet#Installation)

## HiDPI displays
- https://wiki.archlinux.org/title/HiDPI#X_Resources
