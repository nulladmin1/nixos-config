{pkgs, ...}: {
  programs.nix-ld = { 
    enable = true; 
#    libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs; 
  };
}
