{
  lib,
  config,
  ...
}: let
  moduleName = "swappy";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.swappy = {
      enable = true;
      settings = {
        Default = {
          save_dir = config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR;
        };
      };
    };
  };
}
