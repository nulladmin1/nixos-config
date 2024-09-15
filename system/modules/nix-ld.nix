{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  
  programs.nix-ld.libraries = with pkgs; [
    zlib
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
  ];
}
