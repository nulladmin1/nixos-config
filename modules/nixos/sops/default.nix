{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  moduleName = "sops";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      validateSopsFiles = false;
      age = {
        sshKeyPaths = [
          (builtins.toPath "/home/shreyd/.ssh/id_ed25519")
        ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      secrets = {
      };
    };

    environment.systemPackages = with pkgs; [
      sops
    ];
  };
}
