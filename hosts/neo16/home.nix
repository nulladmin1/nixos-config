{
  config,
  editor,
  inputs,
  ...
}: let
  username = config.var.username;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "24.05";

      imports =
        [
          ../../home
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
    };
  };
}