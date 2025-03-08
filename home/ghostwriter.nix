{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.ghostwriter = let
    pointSize = 12;
  in {
    enable = true;
    font = {
      family = config.stylix.fonts.monospace.name;
      inherit pointSize;
    };
    preview.codeFont = {
      family = config.stylix.fonts.monospace.name;
      inherit pointSize;
    };
    general = {
      session = {
        rememberRecentFiles = true;
      };

      fileSaving.backupFileOnSave = true;
    };
    theme = let
      inherit (config.catppuccin) flavor accent;
      themeRepo = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "ghostwriter";
        rev = "183823f462b2a8feccdcc2a5f0ab5a86ac9fd985";
        hash = "sha256-7ptq1Ix0ebqWSUZ6u2mK9UkA4nm/B7R7aK835tr8Wo0=";
      };

      themeName = "catppuccin-${flavor}-${accent}";

      themeFile = "${themeRepo}/themes/${themeName}.json";
    in {
      customThemes = {
        "${themeName}" = themeFile;
      };
      name = themeName;
    };

    window.sidebarOpen = true;
  };
}
