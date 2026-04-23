# Install Oh My Zsh
wget -q -O /tmp/omz-install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
bash /tmp/omz-install.sh --unattended --keep-zshrc --skip-chsh
rm -f /tmp/omz-install.sh

# Make zsh the login shell (omz was run with --skip-chsh)
sudo chsh -s /usr/bin/zsh "$USER"

# Install Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

cp "$OMARCHY_PATH/default/zshrc" "$HOME/.zshrc"

# Link themed zsh theme (config/theme.sh already ran omarchy-theme-set, so the file exists)
ln -snf ~/.config/omarchy/current/theme/sykes_custom_theme.zsh-theme ~/.oh-my-zsh/themes/sykes_custom_theme.zsh-theme
