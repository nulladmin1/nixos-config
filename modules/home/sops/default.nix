{
  system,
  lib,
  config,
  inputs,
  ...
}: let
  moduleName = "sops";
  inherit (config.home) homeDirectory;
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
    ];

    sops = {
      age.keyFile = homeDirectory + "/.config/sops/age/keys.txt";

      defaultSopsFile = ../../../secrets/secrets.yaml;
      validateSopsFiles = false;

      secrets = {
        "private_keys/shreyd" = {
          path = homeDirectory + "/.ssh/id_ed25519";
        };
      };
    };
  };
}
