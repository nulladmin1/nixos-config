{
  lib,
  config,
  ...
}: let
  moduleName = "greetd";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.greetd = {
      enable = true;
    };

    programs.regreet = {
      enable = true;
    };
  };
}
