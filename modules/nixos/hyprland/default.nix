{
  lib,
  config,
  ...
}: let
  moduleName = "hyprland";
  hyprlandSetups = lib.types.enum [
    "caelestia"
    "default"
  ];
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;

    setup = lib.options.mkOption {
      type = hyprlandSetups;
      default = "caelestia";
      description = "Which setup of Hyprland to use? Default, or Caelestia available.";
    };
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
