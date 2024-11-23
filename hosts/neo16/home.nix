{
  config,
  inputs,
  ...
}: let
  username = config.var.username;
  editor = config.var.editor;
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";

  imports =
    [
      ./opts.nix
      ../../home
      ./packages.nix
    ]
    ++ (with inputs; [
      plasma-manager.homeManagerModules.plasma-manager
      nur.hmModules.nur
      catppuccin.homeManagerModules.catppuccin
      stylix.homeManagerModules.stylix
      spicetify-nix.homeManagerModules.default
    ]);

  home.sessionVariables = {
    EDITOR = "${editor}";
  };

  programs.home-manager.enable = true;
}
