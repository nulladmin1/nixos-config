{
  pkgs,
  lib,
  config,
  ...
}: {
  services = {
    displayManager = {
      sddm =
        {
          # Enable SDDM
          enable = false;
          wayland.enable = true;
        }
        // lib.attrsets.optionalAttrs (!config.services.desktopManager.plasma6.enable) {
          package = pkgs.kdePackages.sddm;
        };
    };
  };
}
