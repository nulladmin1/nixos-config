{...}: {
  programs.ssh = {
    enable = true;

    matchBlock = {
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
