#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed waybar networkmanager dunst

ln -sfnv $CURRENT_DIR/waybar/bar $HOME/.config/waybar
ln -sfnv $CURRENT_DIR/waybar/dunst/dunstrc $HOME/.config/dunstrc

