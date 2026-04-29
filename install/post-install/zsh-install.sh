# Install Oh My Zsh from bundled vendor copy
cp -r "$OMARCHY_PATH/vendor/oh-my-zsh" "$HOME/.oh-my-zsh"

# Make zsh the login shell
sudo chsh -s /usr/bin/zsh "$USER"

# Install plugins from bundled vendor copies
cp -r "$OMARCHY_PATH/vendor/zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
cp -r "$OMARCHY_PATH/vendor/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

cp "$OMARCHY_PATH/default/zshrc" "$HOME/.zshrc"

# Link themed zsh theme (config/theme.sh already ran omarchy-theme-set, so the file exists)
ln -snf ~/.config/omarchy/current/theme/sykes_custom_theme.zsh-theme ~/.oh-my-zsh/themes/sykes_custom_theme.zsh-theme
