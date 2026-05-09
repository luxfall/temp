#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed sddm qt5-graphicaleffects

sudo mkdir -p /usr/share/sddm/themes
sudo mkdir -p /etc/sddm.conf.d

sudo systemctl enable sddm

sudo rm -rf /usr/share/sddm/themes/custom
sudo rm -f /etc/sddm.conf.d/wayland.conf
sudo cp -r $CURRENT_DIR/sddm/custom /usr/share/sddm/themes/custom
sudo cp $CURRENT_DIR/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf

