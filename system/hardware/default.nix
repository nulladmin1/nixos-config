{...}: {
  imports = [
    ./kernel.nix
    ./nvidia.nix
    ./system.nix
    #    ./tlp.nix
    ./power-profiles-daemon.nix
  ];
}
