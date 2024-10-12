{
  description = "Main system flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix Index Database
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Plasma-Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR
    nur.url = "github:nix-community/NUR";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Stylix
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-index-database,
    plasma-manager,
    nur,
    catppuccin,
    lanzaboote,
    stylix,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    username = "shreyd";
    hostname = "shrey-neo16-nixos";
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";

    git_username = "nulladmin1";
    git_email = "shrey.deogade@protonmail.com";

    flake = "/home/${username}/nixos-config/";

    locale = "en_US.UTF-8";

    wallpaperDir = pkgs.fetchFromGitHub {
      owner = "nulladmin1";
      repo = "wallpapers";
      rev = "b7c163951f52d29ad242ff535ce0ea4aa85175f5";
      hash = "sha256-wQSGBcQHBpvtULgYLFE4uEsYCJ9E9iZ+njvbseJjte4=";
    };
    wallpaper = "${wallpaperDir}/current-wallpaper.jpg";
    font = "JetBrainsMono Nerd Font";
  in {
    nixosConfigurations.${hostname} = lib.nixosSystem {
      inherit system;
      modules = [
        ./system
        ./shared
        nix-index-database.nixosModules.nix-index
        nur.nixosModules.nur
        {programs.nix-index-database.comma.enable = true;}
        catppuccin.nixosModules.catppuccin
        lanzaboote.nixosModules.lanzaboote
        stylix.nixosModules.stylix
      ];
      specialArgs = {
        inherit username;
        inherit hostname;
        inherit flake;
        inherit locale;
        inherit name;
        inherit wallpaper;
        inherit font;
      };
    };
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager
        ./shared
        plasma-manager.homeManagerModules.plasma-manager
        nur.hmModules.nur
        catppuccin.homeManagerModules.catppuccin
        stylix.homeManagerModules.stylix
      ];
      extraSpecialArgs = {
        inherit username;
        inherit hostname;
        inherit git_email;
        inherit git_username;
      };
    };
  };
}
