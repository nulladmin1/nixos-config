{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland xdg-desktop-portal-hyprland;
in {
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprland;
    portalPackage = xdg-desktop-portal-hyprland;
  };
}
