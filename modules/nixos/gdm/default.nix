{
  lib,
  config,
  ...
}: let
  moduleName = "gdm";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services = {
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
