#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed ssh-tools git

paru -S --noconfirm diff-so-fancy

ln -sfnv "$CURRENT_DIR/git/gitconfig" "$HOME/.gitconfig"
ln -sfnv "$CURRENT_DIR/git/gitignore_global" "$HOME/.gitignore_global"

