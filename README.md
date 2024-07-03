# Arch

## Installing Programs

```bash
sudo pacman -Syu
sudo pacman -S install i3 xorg unzip wget pulseaudio pavucontrol base-devel curl nemo flameshot lightdm lightdm-gtk-greeter telegram-desktop gnu-free-fonts ttf-font-awesome ttf-jetbrains-mono-nerd ttf-liberation noto-fonts-emoji firefox lxappearance zsh eog evince vlc bat xclip brightnessctl playerctl nitrogen alsa-utils xournalpp blueman gvim cronie dunst eza man-db git fastfetch dmenu stow
```

## Systemctl Privileges

```bash
sudo vim /etc/sudoers.d/sysctl
alls ALL = NOPASSWD: /bin/systemctl
```

## Touchpad Configuration
To enable click on tap and scroll with two fingers, create the file
`/etc/X11/xorg.conf.d/50-libinput.conf` with the following content:

```bash
Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Driver "libinput"
    Option "Tapping" "on"
    Option "DisableWhileTyping" "on"
EndSection

Section "InputClass"
    Identifier "touchpad ignore duplicates"
    MatchIsTouchpad "on"
    MatchOS "Linux"
    MatchDevicePath "/dev/input/mouse*"
    Option "Ignore" "on"
    Option "VertTwoFingerScroll" "on"
EndSection
```

## Zsh Configuration
To set zsh as the default shell, run the following command:
```bash
chsh -s $(which zsh)
```

Next, clone the following plugins into the `plugins` folder under `.config/zsh`:
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Lightdm Configuration

Enable the lightdm service to start at boot:
```bash
sudo systemctl enable lightdm
```

Next, open the file `/etc/lightdm/lightdm-gtk-greeter.conf` and insert the following lines:
```bash
[greeter]
background=/usr/share/pixmaps/img1.jpeg
default-user-image=/usr/share/pixmaps/img2.jpeg
```
Is important to place the image in `/usr/share/pixmaps/`.

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
Here are some recommended browser extensions for enhancing your browsing experience:

- [Adblock Plus](https://chromewebstore.google.com/detail/adblock-plus-free-ad-bloc/cfhdojbkjhnklbpkdaibdccddilifddb)
- [Dark Reader](https://chromewebstore.google.com/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh)
- [DeepL Translate](https://chromewebstore.google.com/detail/deepl-translate/cofdbpoegempjloogbagkncekinflcnj)
- [Video Speed Controller](https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk)
- [Rearrange Tabs](https://chrome.google.com/webstore/detail/rearrange-tabs/ccnnhhnmpoffieppjjkhdakcoejcpbga)

## System, Icon, and Cursor Theme
- [Everforest GTK Theme](https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme)
- [Phinger Cursors](https://github.com/phisch/phinger-cursors)

## Enable 'Open in Terminal' in the file explorer
```bash
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
gsettings set org.cinnamon.desktop.default-applications.terminal exec 'alacritty'
```