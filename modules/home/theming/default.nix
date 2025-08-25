{
  lib,
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  moduleName = "theming";
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config = lib.mkIf osConfig.custom.${moduleName}.enable {
    stylix = {
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        light = "Papirus";
        dark = "Papirus-Dark";
      };
      targets = {
        gnome.enable = true;
        gtk.enable = !osConfig.services.desktopManager.plasma6.enable;
      };
    };
    catppuccin = {
      kvantum.enable = false;
      helix.enable = false;

      inherit (osConfig.catppuccin) enable flavor accent;
    };
  };
}
