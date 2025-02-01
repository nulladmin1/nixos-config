{
  config,
  pkgs,
  ...
}: {
  # Enable Jellyfin
  services.jellyfin = let
    inherit (config.var) username;
  in {
    enable = true;
    openFirewall = true;
    user = username;
  };

  environment.systemPackages = with pkgs; [
    # Enable Jellyfin
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
