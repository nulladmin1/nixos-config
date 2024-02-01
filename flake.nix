{

  description = "Main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system ; config = { allowUnfree = true;}; };

      
    in {
    nixosConfigurations = {
      kde = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./modules/wm/kde/use_kde.nix ];
      };
      hyprland = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./modules/wm/hyprland/use_hyprland.nix ];
      };
      qtile = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ./modules/wm/qtile/use_qtile.nix ];
      };
    };
    homeConfigurations = {
      shreyd = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };

}
