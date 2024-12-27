{config, ...}: let
  inherit (config.wayland.windowManager.hyprland) enable;
in {
  stylix.targets.rofi.enable = false;
  catppuccin.rofi.enable = true;
  programs.rofi = {
    inherit enable;
  };
}
