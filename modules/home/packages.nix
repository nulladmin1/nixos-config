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

    alacritty
    bleachbit
    brave
    brightnessctl
    btop
    cinnamon.nemo-with-extensions
    fzf
    gnote
    htop
    obs-studio
    obs-studio-plugins.wlrobs
    rofi
    spicetify-cli
    spotify
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
}