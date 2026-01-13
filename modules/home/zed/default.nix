{
  lib,
  config,
  ...
}: let
  moduleName = "zed";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.zed-editor = {
      enable = true;
    };
  };
}
