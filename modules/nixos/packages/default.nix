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
        adwaita-icon-theme # For some GTK icons
        ifuse # Filesystem support for iOS
        libimobiledevice # To mount iPhone

        # Other
        (nemo-with-extensions.override {
          extensions = [
            nemo-preview
            nemo-emblems
            nemo-fileroller
          ];
        }) # File Manager
        gnome-calculator # Calculator
        gnome-calendar # Calendar
        snapshot # Gnome Camera

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

          # getflake
          getflake
        ]);
  };
}
