{locale, ...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./modules
    ./disko.nix
  ];
}
