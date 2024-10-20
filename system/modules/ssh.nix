{ outpus, lib, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "Dev" = {
        host = "github.com";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/id_ed25519"
        ];
      };
    };
  };
}
