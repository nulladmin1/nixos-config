{
  lib,
  config,
  ...
}: let
  moduleName = "awww";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.awww = {
      enable = true;
    };
  };
}
