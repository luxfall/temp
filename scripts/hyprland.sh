#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed hyprland hyprpolkitagent hyprshutdown hyprpwcenter xdg-desktop-portal-hyprland hyprlock hyprsunset hyprpaper

mkdir -p $HOME/.config/hypr
mkdir -p $HOME/.local/share/wallpapers

ln -sfnv $CURRENT_DIR/hyprland $HOME/.config/hypr

