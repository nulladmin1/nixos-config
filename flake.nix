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

    # My Custom Wallpapers
    wallpapers = {
      url = "github:nulladmin1/wallpapers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Custom Nixvim Configuration
    nixvim = {
      url = "github:nulladmin1/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Hyprland Plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Nix Gaming
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Spicetify-Nix
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    wallpapers,
    disko,
    nixvim,
    hyprland,
    hyprland-plugins,
    nix-gaming,
    spicetify-nix,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.neo16 = lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/neo16
        ./shared
        ./system
        nix-index-database.nixosModules.nix-index
        nur.nixosModules.nur
        {programs.nix-index-database.comma.enable = true;}
        catppuccin.nixosModules.catppuccin
        lanzaboote.nixosModules.lanzaboote
        stylix.nixosModules.stylix
        disko.nixosModules.disko
        nix-gaming.nixosModules.platformOptimizations
      ];
      specialArgs = {
        inherit lib system inputs;
      };
    };
    #    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
    #      inherit pkgs;
    #      modules = [
    #        ./home
    #        ./shared
    #        plasma-manager.homeManagerModules.plasma-manager
    #        nur.hmModules.nur
    #        catppuccin.homeManagerModules.catppuccin
    #        stylix.homeManagerModules.stylix
    #        spicetify-nix.homeManagerModules.default
    #      ];
    #      extraSpecialArgs = [
    #        specialArgs
    #      ];
    #    };
  };
}
