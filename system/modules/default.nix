{ locale, ... }:

{
  imports = [
    ./locales.nix
    ./system.nix
    ./services.nix
    ./tlp.nix
    ./virtualization.nix
  ];
}
