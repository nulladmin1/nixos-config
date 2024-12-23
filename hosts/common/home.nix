{
  config,
  inputs,
  ...
}: let
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

  imports =
    [
      ./opts.nix
      ../../home
      ../../shared
    ]
    ++ (with inputs; [
      catppuccin.homeManagerModules.catppuccin
    ]);

  programs.home-manager.enable = true;
}
