{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (config.var) wallpaper;
  font = config.stylix.fonts.monospace.name;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    image = wallpaper;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";

    cursor = let
      capitalize = str: lib.strings.toUpper (lib.strings.substring 0 1 str) + lib.strings.substring 1 (builtins.stringLength str) str;
      inherit (config.catppuccin) flavor accent;
    in {
      package = pkgs.catppuccin-cursors.${flavor + (capitalize accent)};
      name = "catppuccin-${flavor}-${accent}-cursors";
      size = 24;
    };

    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };

    targets = {
      gnome.enable = true;
      gtk.enable = true;
      feh.enable = true;
    };

    opacity = {
      terminal = 0.9;
    };
  };

  qt = {
    enable = !config.services.desktopManager.plasma6.enable;
    platformTheme = "gtk2";
  };

  # TODO
  catppuccin.sddm = {
    enable = false;
    background = wallpaper;
    inherit font;
  };
}
