{
  inputs,
  config,
  pkgs-stable,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs pkgs-stable;};

    users.${username} = import ../config/home.nix;
  };
}
