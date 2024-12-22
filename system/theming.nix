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

    fonts = {
      monospace = {
        name = "";
      };
    };
  };
}
