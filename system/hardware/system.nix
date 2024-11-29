{config, ...}: let
  inherit (config.var) hostname;
in {
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

  networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Fwupd for firmware
  services.fwupd.enable = true;
}
