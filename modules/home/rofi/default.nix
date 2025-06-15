{
  lib,
  config,
  ...
}: let
  moduleName = "rofi";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    stylix.targets.rofi.enable = false;
    catppuccin.rofi.enable = true;
    programs.rofi = {
      enable = true;
    };
  };
}
