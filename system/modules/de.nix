{ pkgs, lib, ... }:

{
  # Hyprland
  programs.hyprland = {
    enable = true;
  };

  # WayFire
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };

  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  # Gnome
  services.xserver.desktopManager.gnome.enable = true;

  # Enable SDDM
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        catppuccin = {
          background = let
            catppuccin_wallpapers = pkgs.fetchFromGitHub {
              owner = "Gingeh";
              repo = "wallpapers";
              rev = "2530dba028589bda0ef6743d7960bd8a5b016679";
              hash = "sha256-FiilS+t6QszTsnaIFVRRC8pQ6oTcv6qvKMf9cD5AoBQ=";
            };
            in "${catppuccin_wallpapers}/misc/virus.png";
          font = "JetBrainsMono Nerd Font";
        };
      };
    };
  };



}
