{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "printing";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = let
    extraPackages = with pkgs; [
      hplip
    ];
  in
    lib.mkIf config.custom.${moduleName}.enable {
      # Enable CUPS to print documents.
      services.printing = {
        enable = true;
        drivers = extraPackages;
      };

      # Avahi for printing
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      # SANE
      hardware.sane = {
        enable = true;
        extraBackends = extraPackages;
      };
    };
}
