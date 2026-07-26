#!/bin/bash

sudo pacman -Syyu
sudo pacman -S --needed - < pkglist.txt

DOTFILES="$(git rev-parse --show-toplevel)"

mkdir -p $HOME/.config/{foot,fuzzel,hypr,tmux,waybar,dunst,yazi,nvim,xkb,matugen}
mkdir -p $HOME/.local/tmux/plugins
sudo mkdir -p /usr/share/sddm/themes
sudo mkdir -p /etc/sddm.conf.d

sudo cp -rf $DOTFILES/sddm/custom /usr/share/sddm/themes/custom
sudo cp -rf $DOTFILES/sddm/sddm.conf /etc/sddm.conf.d/sddm.conf

git clone https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm

mkdir -p $HOME/.config/oh-my-zsh/custom/themes

stow --verbose --dir=$DOTFILES --target=$HOME/.config/foot foot
stow --verbose --dir=$DOTFILES --target=$HOME/.config/fuzzel fuzzel
stow --verbose --dir=$DOTFILES --target=$HOME/.config/hypr hypr
stow --verbose --dir=$DOTFILES --target=$HOME/.config/tmux tmux
stow --verbose --dir=$DOTFILES --target=$HOME/.config/waybar waybar
stow --verbose --dir=$DOTFILES --target=$HOME/.config/dunst dunst
stow --verbose --dir=$DOTFILES --target=$HOME/.config/yazi yazi
stow --verbose --dir=$DOTFILES --target=$HOME/.config/nvim nvim
stow --verbose --dir=$DOTFILES --target=$HOME/.config/xkb xkb
stow --verbose --dir=$DOTFILES --target=$HOME/.config/matugen matugen
stow --verbose --dir=$DOTFILES --target=$HOME git
stow --verbose --dir=$DOTFILES --target=$HOME zsh
stow --verbose --dir=$DOTFILES --target=$HOME/.config/oh-my-zsh/custom/themes oh-my-zsh
stow --verbose --dir=$DOTFILES --target=$HOME/.config/noctalia noctalia

sudo systemctl enable --now sddm
sudo systemctl enable --now firewalld
sudo systemctl enable --now lactd

ya pkg add yazi-rs/plugins:smart-enter
ya pkg add yazi-rs/plugins:full-border
ya pkg add yazi-rs/plugins:git
ya pkg add yazi-rs/plugins:mount
ya pkg add yazi-rs/plugins:no-status
ya pkg add yazi-rs/plugins:jump-to-char

