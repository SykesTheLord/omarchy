echo "Sykes integration: vim.pack nvim config, Sykes theme, updated keybinds, hypridle, zen-browser"

# 1. Remove omarchy-nvim (LazyVim-based) if installed
if pacman -Q omarchy-nvim &>/dev/null; then
  echo "Backing up existing nvim config"
  [[ -d ~/.config/nvim ]] && cp -r ~/.config/nvim ~/.config/nvim.bak.$(date +%s)
  omarchy-pkg-drop omarchy-nvim
fi

# 2. Install new vim.pack nvim config
echo "Installing new nvim config"
cp -R $OMARCHY_PATH/config/nvim ~/.config/nvim
echo "NOTE: Open nvim and run :TSUpdate to install Tree-sitter parsers"

# 3. Refresh hypridle config and restart
echo "Refreshing hypridle config"
omarchy-refresh-config hypr/hypridle.conf
systemctl --user restart hypridle 2>/dev/null || true

# 4. Refresh bindings
echo "Refreshing hyprland bindings"
omarchy-refresh-config hypr/bindings.conf
hyprctl reload 2>/dev/null || true

# 5. Set zen-browser as default if installed
if omarchy-cmd-present zen-browser; then
  echo "Setting zen-browser as default browser"
  xdg-settings set default-web-browser zen-browser.desktop
  xdg-mime default zen-browser.desktop x-scheme-handler/http
  xdg-mime default zen-browser.desktop x-scheme-handler/https
else
  echo "zen-browser not installed — skipping browser default. Install zen-browser-bin and run omarchy-reinstall-configs"
fi
