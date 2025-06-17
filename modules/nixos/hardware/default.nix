{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "hardware";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    zramSwap.enable = true;
    boot = {
      supportedFilesystems = ["exfat" "ntfs"];
      loader.efi.canTouchEfiVariables = true;
      tmp.cleanOnBoot = true;
    };
    security.polkit.enable = true;

    # Enable all firmware
    hardware.enableAllFirmware = true;

    # Enable networking
    networking.networkmanager.enable = true;

    # Enable bluetooth
    hardware.bluetooth.enable = true;

    # Fwupd for firmware
    services.fwupd.enable = true;

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
