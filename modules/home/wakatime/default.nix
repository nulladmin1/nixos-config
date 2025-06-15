{
  lib,
  config,
  ...
}: let
  moduleName = "wakatime";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    # systemd service to add the Wakatime API key to $WAKATIME_API_KEY
    sops.secrets.hackclub-wakatime-api-key = {};

    sops.templates.".wakatime.cfg" = {
      content = lib.generators.toINI {} {
        settings = {
          api_url = "https://hackatime.hackclub.com/api/hackatime/v1";
          api_key = config.sops.placeholder.hackclub-wakatime-api-key;
          heartbeat_rate_limit_seconds = 30;
        };
      };
      path = config.home.homeDirectory + "/.wakatime.cfg";
    };
  };
}
