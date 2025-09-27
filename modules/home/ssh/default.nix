{
  lib,
  config,
  ...
}: let
  moduleName = "ssh";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        "Git" = {
          host = "github.com";
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_ed25519"
          ];
        };
      };
    };
  };
}
