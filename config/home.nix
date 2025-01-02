{config, ...}: let
  inherit (config.var) username;
  inherit (config.var) editor;
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "${editor}";
    };
  };

  imports = [
    ./opts.nix
    ../home
  ];

  programs.home-manager.enable = true;
}
