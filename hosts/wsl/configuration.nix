{
  config,
  inputs,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    inputs.nixos-wsl.nixosModules.default
<<<<<<< Updated upstream
=======
    ../common/opts.nix
    ../../shared
>>>>>>> Stashed changes

    ../../system/nh.nix
    ../../system/nix.nix
    ../../system/sops.nix
    ../../system/fonts.nix
    ../../system/users.nix
    ../../system/utils.nix
    ../../system/locales.nix
    ../../system/home-manager.nix
    ../../system/theming.nix
  ];

  wsl = {
    enable = true;
    defaultUser = username;
    startMenuLaunchers = true;
  };

  system.stateVersion = "24.11";
}
