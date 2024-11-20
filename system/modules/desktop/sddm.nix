{
  wallpaper,
  font,
  ...
}: {
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
