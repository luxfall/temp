#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed foot eza duf bat fzf thefuck

mkdir -p $HOME/.config/foot/themes

ln -sfnv $CURRENT_DIR/foot/foot.ini $HOME/.config/foot/foot.ini
ln -sfnv $CURRENT_DIR/foot/custom.ini $HOME/.config/foot/themes/custom.ini

