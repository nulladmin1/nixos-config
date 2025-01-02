{
  config,
  inputs,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ../../config

    ../../system/nh.nix
    ../../system/nix.nix
    ../../system/sops.nix
    ../../system/fonts.nix
    ../../system/users.nix
    ../../system/utils.nix
    ../../system/locales.nix
    ../../system/home-manager.nix
  ];

  wsl = {
    enable = true;
    defaultUser = username;
    startMenuLaunchers = true;
  };

  home-manager.users.${username} = import ../../config/home.nix;

  system.stateVersion = "24.11";
}
