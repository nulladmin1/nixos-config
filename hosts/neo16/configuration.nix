{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    inputs.nur.modules.nixos.default
    ../../shared
    ../../system
    ../../system/hardware/boot/systemd-boot.nix
    ../common/opts.nix

    inputs.disko.nixosModules.disko
    ./disko.nix

    inputs.catppuccin.nixosModules.catppuccin
    ./hardware-configuration.nix
  ];

  home-manager.users.${username} = import ../common/home.nix;

  system.stateVersion = "23.11";
}
