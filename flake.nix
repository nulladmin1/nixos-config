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
    ...
  } @ inputs: let
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

    editor = "lvim";

    wallpaper = "${wallpapers.packages.${system}.default}/random.png";
    font = "JetBrainsMono Nerd Font";
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.${hostname} = lib.nixosSystem {
      inherit system;
      modules = [
        ./system
        ./shared
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
        nur.nixosModules.nur
        {programs.nix-index-database.comma.enable = true;}
        catppuccin.nixosModules.catppuccin
        lanzaboote.nixosModules.lanzaboote
        stylix.nixosModules.stylix
        disko.nixosModules.disko
      ];
      specialArgs = {
        inherit username;
        inherit hostname;
        inherit flake;
        inherit locale;
        inherit name;
        inherit wallpaper;
        inherit font;
        inherit system;
        inherit hyprland;
        inherit hyprland-plugins;
        inherit editor;
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
        inherit wallpaper;
        inherit nixvim;
        inherit system;
        inherit hyprland;
        inherit hyprland-plugins;
        inherit editor;
        inherit nix-gaming;
      };
    };
  };
}
