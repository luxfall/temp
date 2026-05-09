#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed tmux git

mkdir -p "$HOME/.local/share/tmux/plugins"
mkdir -p "$HOME/.local/state/tmux"
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.config/tmux"

cargo install tmux-sessionizer
$HOME/.cargo/bin/tms config --paths $HOME/projects $HOME /home
git clone https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm

ln -sfnv "$CURRENT_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
ln -sfnv "$CURRENT_DIR/tmux/themes" "$HOME/.config/tmux/themes"

