# For Home-Manager
{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "candy-icons";

  src = pkgs.fetchurl {
    url = "https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip";
    sha256 = "1b7jh8rcpa35v3i4y1ddfhv29pqw6riishrplyhjyg3rknbzspgq";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  '';
}
