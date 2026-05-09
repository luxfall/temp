#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed fuzzel

#mkdir -p /home/luxfall/.config/fuzzel

ln -sfnv $CURRENT_DIR/fuzzel $HOME/.config/fuzzel

