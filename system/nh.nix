{...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
    # TODO
    flake = "/home/shreyd/nixos-config";
  };
}
