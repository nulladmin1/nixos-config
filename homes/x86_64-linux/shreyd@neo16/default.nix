{...}: {
  custom.apps.enable = true;

  # Set monitor config
  wayland.windowManager.hyprland.settings."monitor" = ",1920x1200@165.00,auto,1";

  # Set mouse
  wayland.windowManager.hyprland.settings.device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };
}
