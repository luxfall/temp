#!/usr/bin/env bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed nvim git

ln -sfnv $CURRENT_DIR/nvim/ $HOME/.config/nvim

