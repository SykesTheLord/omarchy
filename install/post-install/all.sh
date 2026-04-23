run_logged $OMARCHY_INSTALL/post-install/hibernation.sh
run_logged $OMARCHY_INSTALL/post-install/pacman.sh
run_logged $OMARCHY_INSTALL/post-install/zsh-install.sh
run_logged $OMARCHY_INSTALL/post-install/user-dotfiles.sh
run_logged $OMARCHY_INSTALL/post-install/secure-boot.sh
source $OMARCHY_INSTALL/post-install/allow-reboot.sh
source $OMARCHY_INSTALL/post-install/finished.sh
