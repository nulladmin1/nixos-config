{config, ...}: let
  inherit (config.var) git_email git_username;
in {
  ## Allowed Signers file for Git
  home.file.".ssh/allowed_signers".text = "* ${builtins.readFile ../shared/keys/id_ed25519.pub}";

  # Git
  programs.git = {
    enable = true;
    userName = git_username;
    userEmail = git_email;

    extraConfig = {
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
