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
    ./utils.nix
    ./audio.nix
    ./xdg-portal.nix
    ./nix.nix
    ./fonts.nix
    ./home-manager.nix
  ];
}
