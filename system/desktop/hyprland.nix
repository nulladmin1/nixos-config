{pkgs, ...}: {
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
