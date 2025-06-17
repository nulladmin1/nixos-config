{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "jellyfin";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    # Enable Jellyfin
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = "shreyd";
    };

    environment.systemPackages = with pkgs; [
      # Enable Jellyfin
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
