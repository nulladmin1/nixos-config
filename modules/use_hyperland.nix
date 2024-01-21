{ config, pkgs, ... }:

{
  # Enable hyprland and other settings
  programs.hyprland = {
    enable = true;
  };
  
  # Enable Waybar
  programs.waybar.enable = true;

}
