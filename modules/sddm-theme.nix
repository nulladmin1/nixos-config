{ pkgs }:

let
  imgLink = "https://github.com/NixOS/nixos-artwork/blob/master/wallpapers/nix-wallpaper-nineish-dark-gray.png";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "0ajir9496i4fsl1gib3na305xg1qqwcgzkmwwq77mjih5abz5q1c";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MariamArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -r ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  '';
}
