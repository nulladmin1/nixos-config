{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs;
    [
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

      anki
      bat
      bleachbit
      brave
      brightnessctl
      btop
      davinci-resolve
      nemo-with-extensions
      #ciscoPacketTracer8
      feh
      fzf
      ghostwriter
      gimp
      grim
      htop
      inkscape-with-extensions
      kdePackages.kdenlive
      kdePackages.kdevelop
      libreoffice-qt
      obsidian
      obs-studio
      obs-studio-plugins.wlrobs
      openshot-qt
      rofi
      shotcut
      slurp
      tldr
      quickemu

      # Dev
      android-studio
      flutter
      jetbrains.idea-community-bin
      jetbrains.pycharm-community-bin
      jetbrains.rust-rover
      jetbrains-toolbox
      lazygit
      lunarvim
      neofetch
      nodejs
      pkg-config
      scc # Count lines of code by each language
      temurin-bin-17
      thefuck # Auto-correct miss-typed commands
      tmux # Terminal multiplexer
      virtualenv
      zoxide # Better cd

      # Gaming
      ferium
      lutris
      retroarchFull
      xonotic
    ]
    ++ [
      config.nur.repos.shadowrz.klassy-qt6
    ];
}
