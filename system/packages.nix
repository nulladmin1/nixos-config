{
  pkgs,
  inputs,
  ...
}: {
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
      tldr # Better and simpler manpages
      unzip # Unzips .zip files
      vim # Text editor

      # For QT Theming
      (catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["mauve"];
      })
    ]
    ++ (with nur.repos; [
      shadowrz.klassy-qt6
    ])
    ++ (with inputs;
      map (pkg: pkg.packages.${pkgs.system}.default) [
        # My custom Nixvim configuration
        nixvim

        # Comodoro, a Pomodoro app made by Pimalaya
        comodoro
      ]);
}
