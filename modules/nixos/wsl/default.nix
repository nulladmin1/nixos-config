{
  lib,
  config,
  inputs,
  ...
}: let
  moduleName = "wsl";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    custom = {
      audio.enable = true;
      fonts.enable = true;
      kdeconnect.enable = true;
      locales.enable = true;
      nh.enable = true;
      nix.enable = true;
      packages.enable = true;
      printing.enable = true;
      sops.enable = true;
      theming.enable = true;
      users.enable = true;
      utils.enable = true;
      xdg-portal.enable = true;
    };

    wsl = {
      enable = true;
      defaultUser = "shreyd";
      startMenuLaunchers.enable = true;
    };
  };
}
