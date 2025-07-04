# Arch

This repo contains my dotfile configuration, allowing for a consistent computing experience across multiple machines.
These days I primarily use GNU/Linux via the [Arch Linux distribution](https://archlinux.org).

I manage the various configuration files in this repo using [GNU Stow](https://www.gnu.org/software/stow/).  This allows me to set up symlinks for all of my dotfiles using a single command:

```bash
stow .
```

## Inspiration

The inspiration for this configuration comes from [this video](https://www.youtube.com/watch?v=y6XCebnB9gs).

## Installing Programs

```bash
sudo pacman -Syu
yay i3 xorg unzip wget base-devel curl flameshot ttf-jetbrains-mono-nerd noto-fonts-emoji lxappearance zsh eog evince vlc bat xclip brightnessctl feh neovim cronie dunst eza man-db git fastfetch dmenu stow nemo nemo-fileroller blueman alacritty google-chrome visual-studio-code-bin
```

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
