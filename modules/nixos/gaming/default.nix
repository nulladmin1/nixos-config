{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  moduleName = "gaming";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    # Steam
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      # https://github.com/fufexan/nix-gaming#platform-optimizations
      # A bunch of optimizations for Steam from SteamOS
      platformOptimizations.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Gaming
      ferium
      xonotic
      protonup
    ];

    # gamemoderun
    programs.gamemode.enable = true;
  };
}
