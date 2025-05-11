{
  config,
  pkgs,
  ...
}: {
  # Gnome
  services.xserver.desktopManager.gnome.enable = builtins.elem "gnome" config.var.desktopEnvironments;

  environment.gnome.excludePackages = with pkgs; [
    orca
    gnome-software
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell
    caffeine
    clipboard-indicator
  ];
}
