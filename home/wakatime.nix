{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.wakanix.homeManagerModules.wakanix
  ];

  programs.wakanix = {
    enable = false;
    envApiKey = false;
    settings = {
      api_url = "https://waka.hackclub.com/api";
    };
  };

  # systemd service to add the Wakatime API key to $WAKATIME_API_KEY
  sops.secrets.hackclub-wakatime-api-key = {};

  sops.templates.".wakatime.cfg" = let
    cfg = config.programs.wakanix;
  in {
    content =
      (lib.generators.toINI {} ({inherit (cfg) settings;} // cfg.config)) + "api_key=${config.sops.placeholder.hackclub-wakatime-api-key}";
    path = cfg.configFilePath;
  };

  #  systemd.user.services.wakatime-add-api-key = {
  #    Unit = {
  #      Description = "Add Wakatime API Key set by sops-nix to WAKATIME_API_KEY";
  #      After = "sops-nix.service";
  #    };
  #    Service = {
  #      ExecStart = pkgs.writeShellScript "wakatime-add-api-key-script" ''
  #        export WAKATIME_API_KEY=${config.sops.placeholder.hackclub-wakatime-api-key}
  #      '';
  #    };
  #    Install = {
  #      WantedBy = ["default.target"];
  #    };
  #  };
}
