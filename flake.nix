{
  description = "Main system flake";

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (final: prev: (import ./lib final));

    mkPkgs = nixpkgs: system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.fenix.overlays.default
        ];
      };

    mkHost = hostname: {system}:
      lib.nixosSystem {
        inherit system;

        pkgs = mkPkgs nixpkgs system;

        modules = [
          ./hosts/${hostname}/configuration.nix
          ./config
        ];
        specialArgs = let
          pkgs-stable = mkPkgs nixpkgs-stable system;
        in {
          inherit lib system inputs pkgs-stable;
        };
      };

    mkHosts = system: hosts: lib.genAttrs hosts (host: mkHost host {inherit system;});
  in {
    nixosConfigurations = mkHosts "x86_64-linux" [
      "neo16"
      "wsl"
    ];
  };

  inputs = {
    # Nixpkgs main
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Nixpkgs stable
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixos Hardware for hardware settings
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    # Nix Index Database for comma
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plasma-Manager to declaratively manage KDE Plasma
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Lanzaboote for a secure boot implementation
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR for Klassy
    nur.url = "github:nix-community/NUR";

    # Catppuccin for theming
    catppuccin.url = "github:catppuccin/nix";

    # Stylix for theming
    stylix.url = "github:danth/stylix";

    # Disko for declarative disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Gaming for Steam platformOptimizations
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Spicetify-Nix for Spotify theming
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SOPS-Nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Ghostty
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    # Fenix (for Helix and Nixvim)
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ------------------------ MY CUSTOM STUFF -------------------------------
    # My Custom Wallpapers package
    wallpapers = {
      url = "github:nulladmin1/wallpapers";
      flake = false;
    };

    # Wakanix (my custom Wakatime module)
    wakanix = {
      url = "github:nulladmin1/wakanix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Custom Nixvim Configuration
    nixvim = {
      url = "github:nulladmin1/nixvim";
      inputs.fenix.follows = "fenix";
    };

    # My custom Nix-flake-template fetcher
    getflake = {
      url = "github:nulladmin1/getflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
