{...}: {
  imports = [
    ./kernel.nix
    ./graphics.nix
    ./system.nix
    #    ./tlp.nix
    ./power-profiles-daemon.nix

    ./boot
  ];
}
