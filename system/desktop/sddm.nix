{config, ...}: let
  wallpaper = config.var.wallpaper;
  font = config.var.font;
in {
  # Enable SDDM
  services = {
    displayManager = {
      sddm = {
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
