{
  pkgs,
  wallpaper,
  ...
}: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = wallpaper;
  };
}
