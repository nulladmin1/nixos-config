{
  lib,
  config,
  ...
}: let
  moduleName = "plasma";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
