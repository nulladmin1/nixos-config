{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;

    # https://github.com/fufexan/nix-gaming#platform-optimizations
    # A bunch of optimizations for Steam from SteamOS
    platformOptimizations.enable = true;
  };

  environment.systemPackages = with pkgs; [
    protonup
  ];

  # gamemoderun
  programs.gamemode.enable = true;
}
