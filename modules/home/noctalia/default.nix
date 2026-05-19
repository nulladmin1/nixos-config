{
  lib,
  config,
  inputs,
  ...
}: let
  moduleName = "noctalia";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.noctalia-shell = {
      enable = true;
    };
  };
}
