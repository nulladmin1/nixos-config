{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland xdg-desktop-portal-hyprland;
  hyprland-nixpkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.system};
in {
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprland;
    portalPackage = xdg-desktop-portal-hyprland;
  };

  # Better performance in Hyprland
  hardware.graphics = {
    package = hyprland-nixpkgs.mesa.drivers;
    package32 = hyprland-nixpkgs.pkgsi686Linux.mesa.drivers;
  };
}
