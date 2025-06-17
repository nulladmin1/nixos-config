{
  lib,
  config,
  ...
}: let
  moduleName = "ssh";
in {
  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.ssh = {
      enable = true;

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
