{
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

  qt = let
    osTheme = osConfig.qt.platformTheme;
  in {
    inherit (osConfig.qt) enable;
    platformTheme.name = prefer [
      {
        condition = osTheme == "gtk2";
        value = "gtk";
      }
      {
        condition = true;
        value = osTheme;
      }
    ];
    style.name = prefer [
      {
        condition = true;
        value = "kde";
      }
    ];
  };

  # Use the same settings as system catppuccin
  catppuccin = {
    inherit enable flavor accent;
  };
}
