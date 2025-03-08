{
  osConfig,
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig.catppuccin) enable flavor accent;
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  stylix = {
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    targets = {
      gnome.enable = true;
      gtk.enable = true;
      vscode.enable = true;
    };
  };

  catppuccin.kvantum.enable = false;

  qt = {
    inherit (osConfig.qt) enable;
    platformTheme.name = "qt6ct";
  };

  # Use the same settings as system catppuccin
  catppuccin = {
    inherit enable flavor accent;
  };
}
