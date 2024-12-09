{
  description = "Main system flake";

  inputs = {
    # Nixpkgs (nixos-unstable is the perfect version for me)
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
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

    # My Custom Wallpapers packages
    wallpapers = {
      url = "github:nulladmin1/wallpapers";
      flake = false;
    };

    # Disko for declarative disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My Custom Nixvim Configuration
    nixvim = {
      url = "github:nulladmin1/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland Tiling Window Manager
    hyprland.url = "github:hyprwm/Hyprland";

    # Hyprland Plugins for Hyprland
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
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

    # Wakanix (my custom Wakatime module)
    wakanix = {
      url = "github:nulladmin1/wakanix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations = {
      neo16 = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/neo16/configuration.nix
        ];
        specialArgs = {
          inherit lib system inputs;
        };
      };
      wsl = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/wsl/configuration.nix
        ];
        specialArgs = {
          inherit lib system inputs;
        };
      };
    };
  };
}
