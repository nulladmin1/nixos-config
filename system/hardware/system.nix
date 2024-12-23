{...}: {
  # ZRAM Swap
  zramSwap.enable = true;

  # Miscallenous boot settings
  boot = {
    # NTFS + exFat Support
    supportedFilesystems = ["ntfs" "exfat"];

    loader.efi.canTouchEfiVariables = true;

    # Clean TMP on boot
    tmp.cleanOnBoot = true;
  };

  # Enable polkit
  security = {
    polkit.enable = true;
  };

  # Enable all firmware
  hardware.enableAllFirmware = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Fwupd for firmware
  services.fwupd.enable = true;
}
