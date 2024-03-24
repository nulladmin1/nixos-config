{ pkgs, ... }:

{
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

    anki
    alacritty
    bat
    bleachbit
    brave
    brightnessctl
    btop
    burpsuite
    cinnamon.nemo-with-extensions
    # ciscoPacketTracer8
    dunst
    eww
    feh
    fzf
    ghostwriter
    gimp
    grim
    htop
    inkscape-with-extensions
    libnotify
    libreoffice-qt
    lunar-client
    obsidian
    obs-studio
    obs-studio-plugins.wlrobs
    rofi
    slurp
    tldr
    quickemu

    # Dev
    jetbrains.pycharm-community
    jetbrains.rust-rover
    jetbrains-toolbox
    lazygit
    lunarvim
    neofetch
    nodejs
    pkg-config
    python311Packages.dbus-python
    python311Packages.pygobject3
    scc # Count lines of code by each language
    silicon
    thefuck # Auto-correct miss-typed commands
    tmux # Terminal multiplexer
    twine
    virtualenv
    zoxide # Better cd

    # Gaming
    lutris
    xonotic
  ];
}
