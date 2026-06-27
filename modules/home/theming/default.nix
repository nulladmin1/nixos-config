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
      icons = {
        package = pkgs.papirus-icon-theme;
        light = "Papirus";
        dark = "Papirus-Dark";
      };
      targets = {
        gnome.enable = true;
        gtk.enable = true;
      };
    };
    catppuccin = {
      kvantum.enable = false;
      helix.enable = false;

      inherit (osConfig.catppuccin) enable flavor accent;
    };
  };
}
