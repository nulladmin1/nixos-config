{
  lib,
  config,
  ...
}: let
  moduleName = "swww";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.swww = {
      enable = true;
    };
  };
}
