#!/bin/bash
set -e

echo "==> Enabling multilib repository"
sed -i 's/#\[multilib\]/[multilib]/' /etc/pacman.conf
sed -i '/\[multilib\]/{n;s/#Include/Include/}' /etc/pacman.conf
sudo pacman -Sy --noconfirm

echo "==> Installing yay (AUR helper)"
sudo pacman -S --needed --noconfirm git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

echo "==> Installing packages"
yay -S --noconfirm \
    amd-ucode \
    base \
    base-devel \
    dkms \
    yazi \
    dunst \
    efibootmgr \
    fastfetch \
    git \
    grim \
    gst-plugin-pipewire \
    htop \
    hyprland \
    hyprlauncher \
    hyprshutdown \
    kitty \
    libpulse \
    librewolf-bin \
    libva-nvidia-driver \
    linux \
    linux-firmware \
    linux-headers \
    linux-lts \
    linux-lts-headers \
    neovim \
    network-manager-applet \
    networkmanager \
    nvidia-open-dkms \
    pipewire \
    pipewire-alsa \
    pipewire-jack \
    pipewire-pulse \
    polkit-kde-agent \
    qt5-wayland \
    qt6-wayland \
    reflector \
    rsync \
    sddm \
    signal-desktop \
    slurp \
    smartmontools \
    speedtest-cli \
    sudo \
    uwsm \
    vim \
    wget \
    wireplumber \
    noisetorch \
    pavucontrol \
    wofi \
    wpa_supplicant \
    hyprpaper \
    lib32-nvidia-utils \
    lib32-vulkan-icd-loader \
    steam \
    ttf-hack-nerd \
    waybar \
    xdg-desktop-portal-hyprland \
    xdg-utils \
    zram-generator \
    discord \
    flatpak \
    vscodium-bin \
    npm \
    ollama-cuda \
    proton-vpn-cli \
    rofi-wayland \
    ttf-iosevka-nerd \
    nwg-look \
    kvantum \
    qt6ct \
    tokyonight-gtk-theme-git

echo "==> Cloning dotfiles"
git clone https://github.com/cengizozel/iusearchbtw.git ~/dotfiles

echo "==> Linking configs"
mkdir -p ~/.config/rofi/basefiles ~/.config/rofi/colors
ln -sf ~/dotfiles/rofi/config.rasi ~/.config/rofi/config.rasi
ln -sf ~/dotfiles/rofi/basefiles/fonts.rasi ~/.config/rofi/basefiles/fonts.rasi
ln -sf ~/dotfiles/rofi/colors/tokyonight.rasi ~/.config/rofi/colors/tokyonight.rasi

mkdir -p ~/.config/hypr/scripts
ln -sf ~/dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -sf ~/dotfiles/hypr/scripts/swap-enter.sh ~/.config/hypr/scripts/swap-enter.sh
ln -sf ~/dotfiles/hypr/scripts/swap-do.sh ~/.config/hypr/scripts/swap-do.sh
ln -sf ~/dotfiles/hypr/scripts/swap-cancel.sh ~/.config/hypr/scripts/swap-cancel.sh
chmod +x ~/dotfiles/hypr/scripts/*.sh

mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/nvim ~/.config/nvim

mkdir -p ~/.config/hypr
ln -sf ~/dotfiles/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf

mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

mkdir -p ~/.config/waybar
ln -sf ~/dotfiles/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -sf ~/dotfiles/waybar/style.css ~/.config/waybar/style.css

ln -sf ~/dotfiles/bashrc ~/.bashrc

mkdir -p ~/.claude
ln -sf ~/dotfiles/claude/settings.json ~/.claude/settings.json

mkdir -p ~/.config/Kvantum/Kvantum-Tokyo-Night
ln -sf ~/dotfiles/Kvantum/Kvantum-Tokyo-Night/Kvantum-Tokyo-Night.kvconfig ~/.config/Kvantum/Kvantum-Tokyo-Night/Kvantum-Tokyo-Night.kvconfig
ln -sf ~/dotfiles/Kvantum/Kvantum-Tokyo-Night/Kvantum-Tokyo-Night.svg ~/.config/Kvantum/Kvantum-Tokyo-Night/Kvantum-Tokyo-Night.svg
ln -sf ~/dotfiles/Kvantum/kvantum.kvconfig ~/.config/Kvantum/kvantum.kvconfig

mkdir -p ~/.config/qt6ct
ln -sf ~/dotfiles/qt6ct/qt6ct.conf ~/.config/qt6ct/qt6ct.conf

echo "==> Configuring NoiseTorch"
sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch

echo "==> Enabling services"
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now proton-vpn-daemon
sudo systemctl enable sddm

echo "==> Done! Reboot to finish setup."
