{...}: {
  custom.apps.enable = true;

  # Set monitor config
  wayland.windowManager.hyprland.settings."monitor" = ",1920x1200@165.00,auto,1";

  # Set mouse
  wayland.windowManager.hyprland.settings.device = {
    name = "epic-mouse-v1";
    sensitivity = -0.5;
  };

  # Set Niri monitor config
  #
  # You can configure outputs by their name, which you can find
  # by running `niri msg outputs` while inside a niri instance.
  # The built-in laptop monitor is usually called "eDP-1".
  # Find more information on the wiki:
  # https://yalter.github.io/niri/Configuration:-Outputs
  # Remember to uncomment the node by removing "/-"!    };
  programs.niri.settings.outputs."eDP-1" = {
    # Resolution and, optionally, refresh rate of the output.
    # The format is "<width>x<height>" or "<width>x<height>@<refresh rate>".
    # If the refresh rate is omitted, niri will pick the highest refresh rate
    # for the resolution.
    # If the mode is omitted altogether or is invalid, niri will pick one automatically.
    # Run `niri msg outputs` while inside a niri instance to list all outputs and their modes.
    mode = {
      width = 1920;
      height = 1080;
    };

    # Integer or fractional scale.
    scale = 1;

    transform = {
      rotation = 0;
      flipped = false;
    };

    # Position in global coordinate space.
    # This affects directional monitor actions and cursor movement.
    position = {
      x = 1280;
      y = 0;
    };
  };
}
