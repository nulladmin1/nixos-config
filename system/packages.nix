{
  pkgs,
  lib,
  config,
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
      bitwarden-cli # Bitwarden, but CLI
      brave # My browser of choice
      efibootmgr # Manage UEFI boot entries
      fzf # Fuzzy finder
      feh # Image viewer
      ffmpeg-full # Handles multimedia files
      git # Everyone knows what git is
      htop # System monitor
      vlc # Video viewer
      wget # Wget
      speedcrunch # A really good calculator

      # Development
      alejandra # Nix formatter
      flutter # GUI Framework
      go # Programming language
      just # Simple command runner
      lazygit # Git++
      nerdfetch # Fetch utility
      nil # Nix language server
      nodejs # Javascript and stuff
      python3 # Python
      ripgrep # Better grep
      sbctl # For secure boot
      thefuck # Corrects previous console command
      tealdeer # Better and simpler manpages
      unzip # Unzips .zip files
      vim # Text editor

      # For QT Theming
      (catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["mauve"];
      })
    ]
    ++ (with nur.repos; lib.optional config.services.desktopManager.plasma6.enable shadowrz.klassy-qt6 )
    ++ (with inputs;
      map (pkg: pkg.packages.${pkgs.system}.default) [
        # My custom Nixvim configuration
        nixvim

        # Ghostty
        ghostty
      ]);
}
