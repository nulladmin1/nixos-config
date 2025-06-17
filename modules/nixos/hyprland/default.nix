{
  lib,
  config,
  ...
}: let
  moduleName = "hyprland";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    programs.uwsm = {
      enable = true;
    };
  };
}
