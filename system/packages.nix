{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs; [
    nur.modules.nixos.default
  ];

  environment.systemPackages = with pkgs;
    [
      # Core stuff
      bat # Better cat
      brave # My browser of choice
      bitwarden-cli # Password manager
      efibootmgr # Manage UEFI boot entries
      fzf # Fuzzy finder
      feh # Image viewer
      ffmpeg-full # Handles multimedia files
      git # Everyone knows what git is
      htop # System monitor
      vlc # Video viewer
      wget # Wget

      # Development
      alejandra # Nix formatter
      just # Simple command runner
      lazygit # Git++
      nerdfetch # Fetch utility
      nil # Nix language server
      nodejs # Javascript and stuff
      python3 # Python
      ripgrep # Better grep
      sbctl # For secure boot
      unzip # Unzips .zip files
      vim # Text editor

      # For QT Theming
      (catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["mauve"];
      })
    ]
    ++ (with kdePackages; [
      skanpage # Scanning utility
    ])
    ++ (with inputs;
      map (pkg: pkg.packages.${pkgs.system}.default) [
        # My custom Nixvim configuration
        nixvim

        # Ghostty
        ghostty

        # getflake
        getflake
      ]);
}
