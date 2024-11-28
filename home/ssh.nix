{...}: {
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
}
