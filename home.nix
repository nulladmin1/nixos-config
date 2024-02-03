{ config, pkgs, ... }:

{
  imports = [
  ];
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shreyd";
  home.homeDirectory = "/home/shreyd";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    alacritty
    bleachbit
    brave
    brightnessctl
    btop
    cinnamon.nemo-with-extensions
    fzf
    htop
    obs-studio
    obs-studio-plugins.wlrobs
    rofi
    spotify
    spicetify-cli
    tldr

    # Dev
    jetbrains.pycharm-community
    lazygit
    lunarvim
    neofetch
    nodejs
    scc # Count lines of code by each language
    thefuck # Auto-correct miss-typed commands
    tmux # Terminal multiplexer
    virtualenv
    zoxide # Better cd
  ];

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
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # KDEConnect
  services.kdeconnect.enable = true;

  # Bash:
  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
    };
  };

  # Neovim:
  programs.neovim = {
    enable = true;
  };

  # Vscode
  #programs.vscode = {
  #  enable = true;
  #  # package = pkgs.vscodium; # Only if using VSCodium
  #  extensions = with pkgs.vscode-extensions; [
  #    ms-vsliveshare.vsliveshare
  #    eamodio.gitlens
  #  ];
  #};

  # Defaul Applications
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "nemo.desktop";
  };

  # Starship
  programs.starship = 
    let
      flavour = "macchiato";
    in
    {
      enable = true;
      settings = {
        # Other config here
#        format = "$all"; # Remove this line to disable the default prompt format
        palette = "catppuccin_${flavour}";
      } // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "5629d2356f62a9f2f8efad3ff37476c19969bd4f"; # Replace with the latest commit hash
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml));
    };

  # Git
  programs.git = {
    enable = true;
    userName = "nulladmin1";
    userEmail = "shrey.deogade@protonmail.com";
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
  };
  
  # GTK Stuff
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Biba-Modern-Classic";
    };
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
      name = "Catppuccin-Macchiato-Standard-Mauve-Dark";
    };
    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix-Circle";
 #     package = candy-icons;
 #     name = "Candy";
    };

    };

    # QT stuff
    qt = {
      enable = true;
      platformTheme = "gtk3";
      style.name = "gtk2";
    }; 
}

