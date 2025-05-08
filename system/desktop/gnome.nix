{config, ...}: {
  # Gnome
  services.xserver.desktopManager.gnome.enable = builtins.elem "gnome" config.var.desktopEnvironments;
}
