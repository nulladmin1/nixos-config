{
  lib,
  config,
  ...
}: let
  moduleName = "niri";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.swaync.enable = true;
  };
}
