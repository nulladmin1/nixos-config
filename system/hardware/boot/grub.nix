{
  config,
  lib,
  ...
}: {
  # GRUB Bootloader
  boot.loader = lib.mkIf (config.var.bootloader == "grub") {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };
}
