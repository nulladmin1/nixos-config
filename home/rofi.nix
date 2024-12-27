{osConfig, ...}: let
  inherit (osConfig.programs.hyprland) enable;
in {
  stylix.targets.rofi.enable = false;
  catppuccin.rofi.enable = true;
  programs.rofi = {
    inherit enable;
  };
}
