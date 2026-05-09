#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

ln -sfnv "$CURRENT_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sfnv "$CURRENT_DIR/zsh/custom.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/custom.zsh-theme"

