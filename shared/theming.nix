{
  pkgs,
  config,
  ...
}: let
  inherit (config.var) wallpaper;
in {
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";
    image = wallpaper;
  };
}
