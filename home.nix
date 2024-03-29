{ config, pkgs, ... }:

{
  imports = [
  ./modules/home/packages.nix
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
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      h = "history | fzf";
      ":q" = "exit";
      meow = "cat";
      vc = "virtualenv venv";
      va = "source ./venv/bin/activate";
      cd = "z";
      please = "sudo ";
      g = "git";
      push = "git push";
      pull = "git pull";
      commit = "git commit -am";
      edithome = "cd ~/nixos-config/ && lvim home.nix modules/home/packages.nix";
      editsysconf = "cd ~/nixos-config/ && lvim configuration.nix";
      screenshot = "bash $HOME/nixos-config/modules/shell/screenshot.sh"; 
      # showcursor = "printf '\033[?25l'";
      # hidecursor = "printf '\033[?25h'";
    };
  };
  # Neovim:
  programs.neovim = {
    enable = true;
  };

  # VScode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      adpyke.codesnap
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      dbaeumer.vscode-eslint
      eamodio.gitlens
      esbenp.prettier-vscode
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vsliveshare.vsliveshare
      rust-lang.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "yuck";
        publisher = "eww-yuck";
        version = "0.0.3";
        sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
      }
    ];
    # package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup ]); 
  };

  # Defaul Applications
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "nemo.desktop";
    "text/plain" = "brave.desktop";
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

  services.swayosd.enable = true;
  
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

