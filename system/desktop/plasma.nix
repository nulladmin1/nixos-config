{
  pkgs,
  lib,
  ...
}: {
  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
}
