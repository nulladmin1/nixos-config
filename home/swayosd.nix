{config, ...}: let
  inherit (config.wayland.windowManager.hyprland) enable;
  stylePath = config.xdg.configHome + "/swayosd/style.css";
in {
  service.swayosd = {
    inherit enable;
  };

  home.file."${stylePath}".text = ''
    @define-color base #${config.lib.stylix.colors.base00};
    @define-color mantle #${config.lib.stylix.colors.base01};
    @define-color surface0 #${config.lib.stylix.colors.base02};
    @define-color surface1 #${config.lib.stylix.colors.base03};
    @define-color surface2 #${config.lib.stylix.colors.base04};
    @define-color text #${config.lib.stylix.colors.base05};
    @define-color rosewater #${config.lib.stylix.colors.base06};
    @define-color lavender #${config.lib.stylix.colors.base07};
    @define-color red #${config.lib.stylix.colors.base08};
    @define-color peach #${config.lib.stylix.colors.base09};
    @define-color yellow #${config.lib.stylix.colors.base0A};
    @define-color green #${config.lib.stylix.colors.base0B};
    @define-color teal #${config.lib.stylix.colors.base0C};
    @define-color blue #${config.lib.stylix.colors.base0D};
    @define-color mauve #${config.lib.stylix.colors.base0E};
    @define-color flamingo #${config.lib.stylix.colors.base0F};

    window#osd {
      padding: 12px 20px;
      border-radius: 999px;
      border: alpha(@mauve. 0.8);
      background: alpha(@base, 0.8);
    }

    window#osd #container {
      margin: 16px;
    }

    window#osd image,
    window#osd label {
      color: @text;
    }

    window#osd progressbar:disabled,
    window#osd image:disabled {
      opacity: 0.5;
    }

    window#osd progressbar {
      min-height: 6px;
      border-radius: 999px;
      background: transparent;
      border: none;
    }

    window#osd trough {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: alpha(@text, 0.5);
    }

    window#osd progress {
      min-height: inherit;
      border-radius: inherit;
      border: none;
      background: @text;
    }
  '';
}
