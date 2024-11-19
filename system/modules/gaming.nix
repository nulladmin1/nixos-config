{...}: {
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;

    # https://github.com/fufexan/nix-gaming#platform-optimizations
    # A bunch of optimizations for Steam from SteamOS
    platformOptimizations.enable = true;
  };

  # gamemoderun
  programs.gamemode.enable = true;
}
