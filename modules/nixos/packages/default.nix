{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  moduleName = "packages";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    environment.systemPackages = with pkgs;
      [
        # Core stuff
        bat # Better cat
        brave # My browser of choice
        bitwarden-cli # Password manager
        fzf # Fuzzy finder
        feh # Image viewer
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
  };
}
