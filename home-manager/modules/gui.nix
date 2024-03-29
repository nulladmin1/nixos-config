{ config, pkgs, ... }:

{
  # GTK Stuff
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Biba-Modern-Classic";
    };
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        size = "standard";
        tweaks = ["rimless"];
        variant = "macchiato";
      };
      name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
    };
    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix-Circle";
      #     package = candy-icons;
      #     name = "Candy";
    };
  };

  # QT stuff
  qt = {
    enable = true;
    platformTheme = "gtk3";
    style.name = "gtk2";
  };
}