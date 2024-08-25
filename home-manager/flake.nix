{
  description = "For use only with home-manager; not with NixOS";

  inputs = {
    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";

    # Nix Index Database
    nix-index-database.url = "github:nix-community/nix-index-database";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  }: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    homeConfigurations = {
      shreyd = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./. ];
      };
    };
  };
}
