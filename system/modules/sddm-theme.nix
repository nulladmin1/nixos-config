{ pkgs }:

let
  imgLink = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-dark-gray.png";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "TiagoDamascena";
    repo = "sddm-sugar-catppuccin";
    rev = "a7271089a6f990b2df12f34d968a33fb6e3493c9";
    sha256 = "sha256-Q7J6Jt/3V6ZzFH5lCXewHL+HBeNc1hKEzZE3Hjnw9dQ=";
  };
  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    cd $out/
    rm background.jpg
    cp -r ${image} $out/background.jpg
  '';
}
