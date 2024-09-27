{locale, ...}: {
  imports = [
    ./kernel.nix
    ./locales.nix
    ./nvidia.nix
    ./system.nix
    ./services.nix
    ./virtualization.nix
    ./nix-ld.nix
    ./de.nix
  ];
}
