{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (osConfig.catppuccin) enable flavor accent;
  inherit (lib.customLib) prefer;
in {
  stylix.targets = {
    gnome.enable = true;
    gtk.enable = true;
    vscode.enable = true;
    kde.enable = true;
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
