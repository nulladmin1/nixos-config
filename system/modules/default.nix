{...}: {
  imports = [
    ./locales.nix
    ./virtualization.nix
    ./nix-ld.nix
    ./desktop
    ./hardware
    ./nh.nix
    ./gaming.nix
    ./printing.nix
    ./kdeconnect.nix
    ./services.nix
    ./audio.nix
    ./xdg-portal.nix
  ];
}
