{ config, pkgs, ... }:

{
  # Enable Qtile
  services.xserver.windowManager.qtile.enable = true;
  
  # Enable picom
  services.picom.enable = true;
}
