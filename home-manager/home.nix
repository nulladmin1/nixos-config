{
  config,
  pkgs,
  username,
  git_username,
  git_email,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shreyd/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "lvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # KDEConnect
  # services.kdeconnect.enable = true;

  # Neovim:
  programs.neovim = {
    enable = false;
  };

  # Default Applications
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "nemo.desktop";
    "text/plain" = "brave.desktop";
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

  services.swayosd.enable = true;

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    catppuccin.enable = true;
    settings = {
    };
  };

  programs.fastfetch = {
    enable = true;
  };
}
