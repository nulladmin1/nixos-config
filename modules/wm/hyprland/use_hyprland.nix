{ config, pkgs, ... }:

{
  # Enable hyprland and other settings
  programs.hyprland = {
    enable = true;
  };

  # Install hyprpaper
  environment.systemPackages = with pkgs; [ 
    swww
    swaynotificationcenter
    wofi
    wofi-emoji
    waybar
  ];
  
  # Enable Waybar
  programs.waybar.enable = true;

}
