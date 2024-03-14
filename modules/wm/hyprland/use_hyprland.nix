{ config, pkgs, ... }:

{
  imports = [
    ../../programs/tlp.nix
  ];

  # Enable hyprland and other settings
  programs.hyprland = {
    enable = true;
  };

  # Install hyprpaper
  environment.systemPackages = with pkgs; [ 
    swaybg
    swaynotificationcenter
    swww
    wofi
    wofi-emoji
    waybar
  ];
  
  # Enable Waybar
  programs.waybar.enable = true;

}
