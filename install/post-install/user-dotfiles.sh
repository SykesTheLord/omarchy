#!/bin/bash

# Install personal scripts to ~/.scripts (referenced by $PATH in ~/.zshrc)
mkdir -p "$HOME/.scripts"
cp "$OMARCHY_PATH"/default/scripts/* "$HOME/.scripts/"
chmod +x "$HOME/.scripts/"*

# Install tmux config + tpm (plugin manager referenced at the bottom of .tmux.conf)
cp "$OMARCHY_PATH/default/tmux.conf" "$HOME/.tmux.conf"

if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
