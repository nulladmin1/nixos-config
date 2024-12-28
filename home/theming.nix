{
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (osConfig.catppuccin) enable flavor accent;
in {
  stylix.targets = {
    gnome.enable = true;
    gtk.enable = true;
    vscode.enable = true;
    kde.enable = true;
  };

  qt = let
    osTheme = osConfig.qt.platformTheme;
  in {
    inherit (osConfig.qt) enable;
    platformTheme.name =
      if config.catppuccin.kvantum.enable
      then "kvantum"
      else if osTheme == "gtk2"
      then "gtk"
      else osTheme;
    style = lib.mkIf config.catppuccin.kvantum.enable {
      name = "kvantum";
    };
  };

  # Use the same settings as system catppuccin
  catppuccin = {
    inherit enable flavor accent;
  };
}
