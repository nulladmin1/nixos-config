{...}: {
  imports = [
    ./locales.nix
    ./virtualization.nix
    ./nix-ld.nix
    ./desktop
    ./hardware
    ./nh.nix
    ./theming.nix
    ./gaming.nix
    ./printing.nix
    ./kdeconnect.nix
    ./services.nix
  ];
}
