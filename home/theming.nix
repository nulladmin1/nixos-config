{
  osConfig,
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig.catppuccin) enable flavor accent;
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  stylix.targets = {
    gnome.enable = true;
    gtk.enable = true;
    vscode.enable = true;
    kde.enable = true;
  };

  catppuccin.kvantum.enable = false;

  qt = {
    inherit (osConfig.qt) enable;
    platformTheme.name = "qt6ct";
  };

  # Use the same settings as system catppuccin
  catppuccin = {
    inherit enable flavor accent;
  };

  # Ghostwriter
  xdg.dataFile = let
    themeRepo = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "ghostwriter";
      rev = "183823f462b2a8feccdcc2a5f0ab5a86ac9fd985";
      hash = "sha256-7ptq1Ix0ebqWSUZ6u2mK9UkA4nm/B7R7aK835tr8Wo0=";
    };

    themeFile = "catppuccin-${flavor}-${accent}.json";
  in
    lib.mkIf (builtins.elem pkgs.ghostwriter config.home.packages) {
      "ghostwriter/themes/${themeFile}".source = "${themeRepo}/themes/${themeFile}";
    };
}
