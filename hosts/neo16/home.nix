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
      ./packages.nix
      ../../shared
    ]
    ++ (with inputs; [
      catppuccin.homeManagerModules.catppuccin
      stylix.homeManagerModules.stylix
    ]);

  programs.home-manager.enable = true;
}
