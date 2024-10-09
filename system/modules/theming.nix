{ pkgs, lib, wallpaper, font, ... }:
{
  services.displayManager.sddm.catppuccin = {
    background = wallpaper;
    font = font;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
