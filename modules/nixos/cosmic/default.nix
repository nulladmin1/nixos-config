{
  lib,
  config,
  ...
}: let
  moduleName = "cosmic";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.desktopManager.cosmic = {
      enable = true;
    };
  };
}
