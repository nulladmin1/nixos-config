{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    ./opts.nix

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  home-manager.users.${username} = import ./home.nix;

  system.stateVersion = "24.11";
}
