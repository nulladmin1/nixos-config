{
  config,
  pkgs,
  ...
}: let
  inherit (config.var) wallpaper;
  inherit (config.var) font;
in {
  services = {
    displayManager = {
      sddm = {
        # Enable SDDM

        enable = true;
        wayland.enable = true;

        package = pkgs.kdePackages.sddm;

        catppuccin = {
          background = wallpaper;
          inherit font;
        };
      };
    };
  };
}
