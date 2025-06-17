{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "sddm";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services = {
      displayManager = {
        sddm =
          {
            enable = false;
            wayland.enable = true;
          }
          // lib.attrsets.optionalAttrs (!config.services.desktopManager.plasma6.enable) {
            package = pkgs.kdePackages.sddm;
          };
      };
    };
  };
}
