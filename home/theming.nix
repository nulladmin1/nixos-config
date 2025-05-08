{
  osConfig,
  inputs,
  pkgs,
  ...
}: let
  inherit (osConfig.catppuccin) enable flavor accent;
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];
  stylix = {
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    targets = {
      gnome.enable = true;
      gtk.enable = !osConfig.services.desktopManager.plasma6.enable;
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
