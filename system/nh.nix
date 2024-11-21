{config, ...}: let
  flake = config.var.flake;
in {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
    flake = flake;
  };
}
