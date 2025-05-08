{config, ...}: {
  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = builtins.elem "plasma" config.var.desktopEnvironments;
  #   programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
}
