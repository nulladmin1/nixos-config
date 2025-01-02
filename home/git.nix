{config, ...}: let
  inherit (config.var) email git_username sshKeyPath;
in {
  ## Allowed Signers file for Git
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile sshKeyPath}";

  # Git
  programs.git = {
    enable = true;
    userName = git_username;
    userEmail = email;

    extraConfig = {
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  # GitHub
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
