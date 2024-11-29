{config, ...}: let
  inherit (config.var) wallpaper;
  inherit (config.var) font;
in {
  services = {
    displayManager = {
      sddm = {
        # Enable SDDM

        enable = true;
        wayland.enable = true;

        catppuccin = {
          background = wallpaper;
          inherit font;
        };
      };
    };
  };
}
