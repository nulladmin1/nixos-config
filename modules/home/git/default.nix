{
  lib,
  config,
  ...
}: let
  moduleName = "git";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    # Git
    programs.git = {
      enable = true;
      userName = "nulladmin1";
      userEmail = "shrey.deogade@protonmail.com";

      extraConfig = {
        commit.gpgsign = true;
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        };
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };

    # GitHub CLI
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    ## Allowed Signers file for Git:
    home.file.".ssh/allowed_signers".text = "* ${builtins.readFile ../../../secrets/id_ed25519.pub}";
  };
}
