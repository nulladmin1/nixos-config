{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      vim
      wget
      unzip
      efibootmgr
      ffmpeg-full
      vlc
      sbctl
      bat
      brave
      feh
      fzf
      tldr
      htop
      ripgrep
      git
      go
      python3
      rustup
      alejandra
      nil
      just
      lazygit
      flutter
      nodejs
      nerdfetch
      thefuck

      # For QT Theming
      (catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["mauve"];
      })
    ]
    ++ (with nur.repos; [
      shadowrz.klassy-qt6
    ])
    ++ [
      # My custom Nixvim configuration
      inputs.nixvim.packages.${pkgs.system}.default
    ];
}
