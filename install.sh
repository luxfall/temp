#!/bin/bash

sudo pacman -Syyu
sudo pacman -S --needed - < pkglist.txt

DOTFILES="$(git rev-parse --show-toplevel)"

#mkdir -p $HOME/.config/{foot,fuzzel,hypr,tmux,nvim,xkb}
mkdir -p $HOME/.config/{foot,hypr,tmux,nvim,xkb,matugen,noctalia,qt5ct}
mkdir -p $HOME/.local/tmux/plugins
mkdir -p $HOME/.config/oh-my-zsh/custom/themes

git clone https://github.com/tmux-plugins/tpm $HOME/.local/share/tmux/plugins/tpm

stow --verbose --dir=$DOTFILES --target=$HOME/.config/foot foot
stow --verbose --dir=$DOTFILES --target=$HOME/.config/hypr hypr
stow --verbose --dir=$DOTFILES --target=$HOME/.config/tmux tmux
stow --verbose --dir=$DOTFILES --target=$HOME/.config/nvim nvim
stow --verbose --dir=$DOTFILES --target=$HOME/.config/xkb xkb
stow --verbose --dir=$DOTFILES --target=$HOME/.config/matugen matugen
stow --verbose --dir=$DOTFILES --target=$HOME git
stow --verbose --dir=$DOTFILES --target=$HOME zsh
stow --verbose --dir=$DOTFILES --target=$HOME/.config/oh-my-zsh/custom/themes oh-my-zsh
stow --verbose --dir=$DOTFILES --target=$HOME/.config/noctalia noctalia
stow --verbose --dir=$DOTFILES --target=$HOME/.config kde
stow --verbose --dir=$DOTFILES --target=$HOME/.config/btop btop
stow --verbose --dir=$DOTFILES --target=$HOME/.config/qt6ct qt

systemctl --user enable hyprpolkitagent
#sudo systemctl enable --now firewalld
#sudo systemctl enable --now lactd

