{config, ...}: let
  inherit (config.var) username;
in {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = username;
  };
}
