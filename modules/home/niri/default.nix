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
}
