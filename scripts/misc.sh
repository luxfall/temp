#!/bin/bash

sudo pacman -S --noconfirm --needed mpv btrfs-assistant lact zip unzip grim slurp cliphist wl-clipboard firewalld betterbird-bin


sudo systemctl enable --now firefalld
sudo systemctl enable --now lactd

