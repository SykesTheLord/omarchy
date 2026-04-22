echo "Sync oh-my-zsh theme to Omarchy theme system"

CURRENT="$HOME/.config/omarchy/current/theme"
NEXT="$HOME/.config/omarchy/current/next-theme"

if [[ -d $CURRENT ]]; then
  rm -rf "$NEXT"
  cp -r "$CURRENT" "$NEXT"
  omarchy-theme-set-templates
  rm -rf "$CURRENT"
  mv "$NEXT" "$CURRENT"
fi

ln -snf ~/.config/omarchy/current/theme/sykes_custom_theme.zsh-theme ~/.oh-my-zsh/themes/sykes_custom_theme.zsh-theme
