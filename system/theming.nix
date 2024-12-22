{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (config.var) wallpaper;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";
    image = wallpaper;
    enable = true;
    autoEnable = false;

    cursor = let
      capitalize = str: lib.strings.toUpper (lib.strings.substring 0 1 str) + lib.strings.substring 1 (builtins.stringLength str) str;
    in {
      package = pkgs.catppuccin-cursors.${config.catppuccin.flavor + (capitalize config.catppuccin.accent)};
      name = "catppuccin-${config.catppuccin.flavor}-${config.catppuccin.accent}-cursors";
      size = 24;
    };

    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };

    targets.gtk = {
      enable = true;
    };

    opacity = {
      terminal = 0.9;
    };
  };

  qt = {
    enable = !config.services.desktopManager.plasma6.enable;
    platformTheme = "gtk2";
  };
}
