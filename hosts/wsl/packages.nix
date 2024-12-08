{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.hmModules.nur
  ];
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

      # My nixvim config
      #      inputs.nixvim.packages.${pkgs.system}.default

      # Stuff
      anki
      bat
      brave
      #ciscoPacketTracer8
      discord
      feh
      fzf
      ghostwriter
      gimp
      htop
      inkscape
      kolourpaint
      libreoffice-qt6-still
      nerdfetch
      obs-studio
      obs-studio-plugins.wlrobs
      okular
      ripgrep
      spicetify-cli
      #spotify
      swww
      tldr

      # Dev
      flutter
      jetbrains-toolbox
      lazygit
      #lunarvim
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
      retroarch
      xonotic
    ]
    ++ (with pkgs.jetbrains; [
      idea-ultimate
      clion
      rust-rover
    ])
    ++ (with pkgs.kdePackages; [
      kdenlive
      qt6ct
    ]);
}
