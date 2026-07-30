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

    # Disable Jellyfin on boot
    systemd.services.jellyfin.wantedBy = lib.mkForce [];

    environment.systemPackages = let
      # Create script to toggle Jellyfin
      jellyfinToggle = pkgs.writeShellScriptBin "jellyfin-toggle" ''
        if systemctl is-active --quiet jellyfin.service; then
          pkexec systemctl stop jellyfin.service
          ${pkgs.libnotify}/bin/notify-send "Jellyfin Stopped"
        else
          pkexec systemctl start jellyfin.service
          ${pkgs.libnotify}/bin/notify-send "Jellyfin Started"
        fi
      '';
    in
      with pkgs; [
        # Enable Jellyfin
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg

        jellyfinToggle
        (pkgs.makeDesktopItem {
          name = "jellyfin-toggle";
          desktopName = "Jellyfin (Toggle)";
          exec = "${jellyfinToggle}/bin/jellyfinToggle";
          categories = ["AudioVideo"];
          icon = "jellyfin";
        })
      ];
  };
}
