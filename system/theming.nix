{
  pkgs,
  config,
  ...
}: let
  inherit (config.var) wallpaper;
in {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";
    image = wallpaper;
    enable = true;

    fonts = {
      monospace = {
        name = "";
      };
    };
  };
}
