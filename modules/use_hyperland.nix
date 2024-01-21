{ config, pkgs, ... }:

{
  # Enable hyprland and other settings
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };
  
  # Enable Waybar
  programs.waybar.enable = true;

}
