{config, ...}: {
  # Hyprland
  programs.hyprland = {
    enable = builtins.elem "hyprland" config.var.desktopEnvironments;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.uwsm = {
    enable = builtins.elem "hyprland" config.var.desktopEnvironments;
  };
}
