{pkgs, ...}: {
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    libnet
    zlib
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
  ];
}
