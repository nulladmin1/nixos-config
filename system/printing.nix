{pkgs, ...}: let
  extraPackages = with pkgs; [
    hplip
  ];
in {
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
}
