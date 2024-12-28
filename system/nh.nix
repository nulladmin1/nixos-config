{config, ...}: let
  inherit (config.var) flake;
in {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
    inherit flake;
  };
}
