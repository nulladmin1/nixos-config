{
  inputs,
  config,
  osConfig,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma = let
    inherit (config.var) wallpaper;
  in {
    inherit (osConfig.services.desktopManager.plasma6) enable;

    workspace = {
      inherit wallpaper;
      lookAndFeel = "Catppuccin-Mocha-Mauve";
      colorScheme = "CatppuccinMochaMauve";
      iconTheme = config.stylix.iconTheme.dark;

      cursor = {
        inherit (config.stylix.cursor) size;
        theme = config.stylix.cursor.name;
      };
    };

    fonts = {
      fixedWidth = {
        family = config.stylix.fonts.monospace.name;
        pointSize = 12;
      };
    };

    hotkeys.commands = {
      "Launch-Alacritty" = {
        name = "Launch Alacritty";
        command = "alacritty";
        comment = "Launch Alacritty terminal emulator";
        key = "Meta+Return";
      };
    };

    krunner = {
      shortcuts.launch = "Meta+R";
    };

    kscreenlocker = {
      appearance = {
        inherit wallpaper;
      };
    };

    kwin = {
      effects = {
        blur.enable = true;
        cube.enable = true;
        fallApart.enable = true;
        minimization.animation = "magiclamp";
        translucency.enable = true;
        wobblyWindows.enable = true;
      };
    };
  };
}
