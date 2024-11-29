{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../secrets.yaml;
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
}
