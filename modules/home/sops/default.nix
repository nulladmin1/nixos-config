{
  osConfig,
  lib,
  config,
  inputs,
  ...
}: let
  moduleName = "sops";
  inherit (config.home) homeDirectory;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  config = lib.mkIf osConfig.custom.${moduleName}.enable {
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
