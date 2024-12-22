{
  config,
  pkgs,
  ...
}: let
  inherit (config.var) wallpaper;
  inherit (config.var) font;
in {
  catppuccin.sddm = {
    enable = true;
    background = wallpaper;
    inherit font;
  };
  services = {
    displayManager = {
      sddm = {
        # Enable SDDM

        enable = true;
        wayland.enable = true;

        package = pkgs.kdePackages.sddm;
      };
    };
  };
}
