{ config, pkgs, ... }:

{
  imports = [
    ./picom.nix
  ];

  # Enable Qtile
  services.xserver.windowManager.qtile.enable = true;
}
