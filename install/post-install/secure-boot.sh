# Set up Secure Boot keys and sign EFI binaries
sudo sbctl create-keys

# Enroll keys including Microsoft's UEFI CA (required for Windows dual-boot
# and for option ROM firmware that ships with Microsoft signatures)
if bootctl status 2>/dev/null | grep -q 'Setup Mode: enabled'; then
  sudo sbctl enroll-keys -m
else
  echo "Secure Boot key enrollment skipped: firmware not in Setup Mode."
  echo "To complete Secure Boot setup after reboot:"
  echo "  1. Enter UEFI firmware and enable Setup Mode (or clear existing keys)"
  echo "  2. Run: sudo sbctl enroll-keys --microsoft"
fi

# Sign the UKI and Limine EFI binaries (-s saves paths for automatic re-signing on updates)
for efi in \
  /boot/EFI/Linux/omarchy.efi \
  /boot/EFI/Linux/omarchy-fallback.efi \
  /boot/EFI/BOOT/BOOTX64.EFI \
  /boot/EFI/limine/BOOTX64.EFI \
  /boot/EFI/arch-limine/BOOTX64.EFI; do
  [[ -f $efi ]] && sudo sbctl sign -s "$efi"
done
