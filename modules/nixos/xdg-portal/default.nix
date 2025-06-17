{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "xdg-portal";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    xdg.portal = {
      enable = true;
      config.common.default = "*";
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };
}
