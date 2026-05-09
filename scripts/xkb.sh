#!/bin/bash

CURRENT_DIR="$(git rev-parse --show-toplevel)"

ln -sfnv "$CURRENT_DIR/xkb/" "$HOME/.config/xkb"

