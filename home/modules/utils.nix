{
  pkgs,
  git_email,
  git_username,
  ...
}: {
  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.9;
        blur = true;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
      };
    };
  };

  # KDEConnect
  # services.kdeconnect.enable = true;

  # Neovim:
  programs.neovim = {
    enable = false;
  };

  # Git
  programs.git = {
    enable = true;
    userName = git_username;
    userEmail = git_email;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zellij = {
    enable = true;
    #    enableBashIntegration = true;
    catppuccin.enable = true;
    settings = {
    };
  };

  programs.fastfetch = {
    enable = true;
  };

  programs.btop = {
    enable = true;
  };
}