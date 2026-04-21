echo "Set up Secure Boot with sbctl and sign EFI binaries"

sudo pacman -S --noconfirm --needed sbctl

# Only create keys if they don't already exist
if ! sudo sbctl status 2>/dev/null | grep -q 'Installed.*✓'; then
  sudo sbctl create-keys
fi

if bootctl status 2>/dev/null | grep -q 'Setup Mode: enabled'; then
  sudo sbctl enroll-keys --microsoft
else
  echo "Secure Boot enrollment skipped: enable Setup Mode in UEFI firmware, then run: sudo sbctl enroll-keys --microsoft"
fi

for efi in \
  /boot/EFI/Linux/omarchy.efi \
  /boot/EFI/Linux/omarchy-fallback.efi \
  /boot/EFI/BOOT/BOOTX64.EFI \
  /boot/EFI/limine/BOOTX64.EFI \
  /boot/EFI/arch-limine/BOOTX64.EFI; do
  [[ -f $efi ]] && sudo sbctl sign -s "$efi"
done
