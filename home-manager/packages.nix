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
      brave
      btop
      nemo-with-extensions
      #ciscoPacketTracer8
      feh
      fzf
      ghostwriter
      gimp
      grim
      htop
      obsidian
      obs-studio
      obs-studio-plugins.wlrobs
      rofi
      slurp
      tldr
      quickemu

      # Dev
      android-studio
      flutter
      jetbrains.idea-ultimate
      jetbrains.clion
      jetbrains.pycharm-professional
      jetbrains.rust-rover
      jetbrains.webstorm
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
    ++ (with config.nur.repos; [
      shadowrz.klassy-qt6
    ]);
}
