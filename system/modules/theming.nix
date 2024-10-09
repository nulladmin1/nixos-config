{
  pkgs,
  lib,
  wallpaper,
  font,
  ...
}: {
  services.displayManager.sddm.catppuccin = {
    background = wallpaper;
    inherit font;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
