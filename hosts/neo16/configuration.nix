{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    ../../system
    ../../system/hardware/boot/systemd-boot.nix
    ../common/opts.nix

    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.catppuccin.nixosModules.catppuccin
    ./hardware-configuration.nix
  ];
  networking = {
    hostName = "neo16";
    nameservers = ["1.1.1.1" "1.0.0.1"];
    interfaces = {
      enp109s0.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };

  home-manager.users.${username} = import ../common/home.nix;

  system.stateVersion = "23.11";
}
