{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "gnome";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    services.desktopManager.gnome.enable = true;

    environment.gnome.excludePackages = with pkgs; [
      orca
      gnome-software
    ];

    environment.systemPackages = with pkgs.gnomeExtensions; [
      blur-my-shell
      caffeine
      clipboard-indicator
      gsconnect
    ];
  };
}
