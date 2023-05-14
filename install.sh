#!/bin/bash
# Experimental script to automate the installation of this script. Might contain bugs. 
# USE THIS AT YOUR OWN RISK!
#This script is written with the assumption that you're on an Arch based distro with yay as your helper. 
#This script doesn't include the packages installed by the endeavour installer.


install_packages() {
  echo "Installing required packages" 
  gpu=$(lspci | grep -i nvidia)
  if [[ $gpu = *"NVIDIA"* ]] 
    then
      yay -S --noconfirm hyprland-nvidia
      echo "WLR_NO_HARDWARE_CURSORS=1" >> /etc/environment
  else
    yay -S --noconfirm hyprland
  fi

  yay -S --noconfirm tmux cmatrix zsh galendae-git grim \
    neovim imagemagick feh grub-customizer zsh-theme-powerlevel10k-git \
    ttf-meslo-nerd-font-powerlevel10k zsh rofi-ibonn-wayland polkit-kde-agent xdg-desktop-portal-hyprland cliphist udiskie \
    otf-font-awesome noto-fonts-emoji gtk4 blueberry hyprpaper montserrat-ttf obsidian nm-applet gnome-keyring

  echo "Installing Oh-my-Zsh"

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"





}

discord() {
  echo "Copying BetterDiscord configurations"
  cd .config || exit
  cp -r BetterDiscord ~/.config
}

hyprland() {
  echo "Copying hyprland configurations"
  cd .config || exit
  cp -r hypr ~/.config/
}


neofetch() {
  echo "Copying neofetch configurations"
  cd .config || exit
  cp -r neofetch ~/.config/
}


gtk_theme() {
  echo "Installing gtk_theme"
  cp -r .config/gtk-2.0 ~/.config/
  cp -r .config/gtk-3.0 ~/.config/
  cp -r .config/gtk-4.0 ~/.config/
  cp -r .themes ~/
  cp -r .icons ~/
}

rofi() {
  echo "Copying rofi configurations"
  cp -r .config/rofi ~/.config
}

spicetify() {
  echo "Copying spicetify configurations"
  cp -r .config/spicetify ~/.config
}

swaync() {
  echo "Copying swaync configurations"
  cp -r .config/swaync ~/.config
}

waybar() {
  echo "Copying waybar configurations"
  cp -r .config/waybar ~/.config
}

wlogout() {
  echo "Copying wlogout configurations"
  cp -r .config/wlogout ~/.config/
}


tmux() {
  echo "Copying tmux configurations"
  cp -r .tmux ~/
  cp .tmux.conf ~/
}

all() {
  echo "Installing Packages"
  install_packages
  echo "Copying all available configurations"
  cp -ra ./. ~/
}

help() {
  echo "Usage: ./install.sh [options]"
  echo
  echo "  --swaync      copies configs for swaync"
  echo "  --tmux        copies configs for tmux"
  echo "  --waybar      copies configs for waybar"
  echo "  --wlogout     copies configs for wlogout"
  echo "  --spicetify   copies configs for spicetify"
  echo "  --rofi        copies configs for rofi"
  echo "  --gtk         copies the gtk theme and its icons into your home folder"
  echo "  --neofetch    copies configs for neofetch"
  echo "  --hyprland    copies configs for hyprland"
  echo "  --discord     copies configs for BetterDiscord"
  echo "  --all         copies all available configs"
  echo "This script automatically installes the required packages only for the --all flag. For others, it is assumed that you have the necessary packages installed"
}





options=$(getopt -o "" --long all,swaync,tmux,waybar,wlogout,spicetify,rofi,gtk,neofetch,discord,hyprland: -n 'script.sh' -- "$@")
if [[ $# -lt 1 ]]
then
  help
else
  eval set -- "$options"
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --all)
        all
        exit 0
        ;;
      --swaync)
        swaync
        ;;
      --tmux)
        tmux
        ;;
      --waybar)
        waybar
        ;;
      --wlogout)
        wlogout
        ;;
      --spicetify)
        spicetify
        ;;
      --rofi)
        rofi
        ;;
      --gtk)
        gtk
        ;;
      --neofetch)
        neofetch
        ;;
      --discord)
        discord
        ;;
      --hyprland)
        hyprland
        ;;
    esac
    shift
  done
fi

