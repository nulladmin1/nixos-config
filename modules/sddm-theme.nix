{ pkgs }:

let
  imgLink = "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-nineish-dark-gray.png";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "sha256-kChAAdd6g6uz1LP4cpy0uzxBt1EgKBc1R39CVWJl73s=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MariamArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
  };
  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  '';
}
