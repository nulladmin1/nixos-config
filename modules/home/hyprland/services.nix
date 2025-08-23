{
  lib,
  config,
  osConfig,
  ...
}: let
  cfg = osConfig.custom.hyprland;
  setup = cfg.setup;
in {
  services = {
    swaync = {
      enable = setup == "default";
    };

    hypridle = {
      enable = true;
      settings = {
        general =
          {
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          }
          // lib.attrsets.optionalAttrs (setup == "default") {
            lock_cmd = "hyprlock";
          }
          // lib.attrsets.optionalAttrs (setup == "caelestia") {
            lock_cmd = "caelestia shell lock lock";
          };

        listener = [
          {
            timeout = 180;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 300;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs.hyprlock = {
    enable = setup == "default";
    settings = let
      layout = let
        text = "rgb(${config.lib.stylix.colors.base05})";
        accent = "rgb(${config.lib.stylix.colors.base0E})";
        red = "rgb(${config.lib.stylix.colors.base08})";
      in
        lib.attrsets.optionalAttrs (!config.catppuccin.hyprlock.enable) {
          input-field =
            {
              monitor = "";
              size = "80px, 60px";
              outline_thickness = 3;
              fade_on_empty = false;
              rounding = 15;

              position = "0, -50";
              halign = "center";
              valign = "center";
            }
            // lib.attrsets.optionalAttrs (!config.stylix.targets.hyprlock.enable) {
              outer_color = accent;
              check_color = accent;

              fail_color = red;
              inner_color = text;
              font_color = text;
            };

          label = [
            {
              monitor = "";
              text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
              color = text;
              font_size = 24;
              font_family = config.stylix.fonts.monospace.name;
              position = "0, 220";
              halign = "center";
              valign = "center";
            }

            {
              monitor = "";
              text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
              color = text;
              font_size = 96;
              font_family = "${config.stylix.fonts.monospace.name} Extrabold";
              position = "0, 120";
              halign = "center";
              valign = "center";
            }
          ];
        };
    in
      {
        background =
          {
            monitor = "";
            blur_passes = 2;
          }
          // lib.attrsets.optionalAttrs (!config.stylix.targets.hyprlock.enable) {
            path = config.stylix.image;
          };

        general = {
          hide_cursor = false;
        };
      }
      // layout;
  };
}
