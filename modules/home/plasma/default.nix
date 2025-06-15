{
  lib,
  config,
  inputs,
  osConfig,
  ...
}: let
  moduleName = "plasma";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    imports = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];

    programs.plasma = let
      wallpaper = "${inputs.wallpapers}/Arcane/arcane_powder_ekko_looking.png";
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

      shortcuts = {
        KWin = {
          "Switch to Desktop 1" = "Meta+1";
          "Switch to Desktop 2" = "Meta+2";
          "Switch to Desktop 3" = "Meta+3";
          "Switch to Desktop 4" = "Meta+4";
          "Switch to Desktop 5" = "Meta+5";
          "Switch to Desktop 6" = "Meta+6";
          "Switch to Desktop 7" = "Meta+7";
          "Switch to Desktop 8" = "Meta+8";
          "Switch to Desktop 9" = "Meta+9";
          "Switch to Desktop 10" = "Meta+0";

          "Window to Desktop 1" = "Meta+Shift+1";
          "Window to Desktop 2" = "Meta+Shift+2";
          "Window to Desktop 3" = "Meta+Shift+3";
          "Window to Desktop 4" = "Meta+Shift+4";
          "Window to Desktop 5" = "Meta+Shift+5";
          "Window to Desktop 6" = "Meta+Shift+6";
          "Window to Desktop 7" = "Meta+Shift+7";
          "Window to Desktop 8" = "Meta+Shift+8";
          "Window to Desktop 9" = "Meta+Shift+9";
          "Window to Desktop 10" = "Meta+Shift+0";

          "Close Window" = "Meta+W";
          "Make Window Fullscreen" = "Meta+F";
          "Toggle Overview" = "Meta+Tab";
        };
      };

      krunner = {
        shortcuts.launch = "Meta+R";
        position = "center";
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
  };
}
