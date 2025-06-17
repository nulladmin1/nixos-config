{
  config,
  lib,
  inputs,
}: {
  imports =
    [
      inputs.disko.nixosModules.disko
      ./disko.nix

      # Nvidia
      ./nvidia.nix

      # Grub
      ./boot.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-intel-cpu-only
      common-pc-laptop
      common-pc-laptop-ssd
    ]);

  # Custom module imports
  custom.common.enable = true;
  custom.jellyfin.enable = true;

  # Network configuration
  networking = {
    hostName = "neo16";
    interfaces = {
      enp109s0.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
    resolvconf.enable = false;
    networkmanager = {
      insertNameservers = ["1.1.1.1" "1.0.0.1"];
    };
  };

  system.stateVersion = "23.11";
}
