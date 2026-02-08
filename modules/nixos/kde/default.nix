{
  lib,
  pkgs,
  config,
  ...
}: let
  moduleName = "kde";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.desktopManager.plasma6 = {
      enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
      elisa
      plasma-browser-integration
      ark
      khelpcenter
    ];
  };
}
