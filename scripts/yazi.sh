#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

sudo pacman -S --noconfirm --needed yazi ark zip

ln -sfnv $CURRENT_DIR/yazi $HOME/.config/yazi

ya pkg add yazi-rs/plugins:smart-enter
ya pkg add yazi-rs/plugins:full-borders
ya pkg add yazi-rs/plugins:vcs-files

