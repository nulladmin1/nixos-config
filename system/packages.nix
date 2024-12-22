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
      alacritty
      vlc
      sbctl

      # Dev
      git
      go
      python3
      rustup
      alejandra
      nil
      just

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
