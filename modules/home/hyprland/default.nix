{
  lib,
  config,
  pkgs,
  osConfig,
  inputs,
  ...
}: let
  moduleName = "hyprland";

  wallpaper = config.stylix.image;

  # The space between windows to line up Hyrpland and Waybar
  windows_space_gap = 15;

  cfg = osConfig.custom.${moduleName};
  setup = cfg.setup;
in {
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  config = lib.mkIf cfg.enable {
    custom = {
      rofi.enable = true;
      swayosd.enable = true;
    };

    home.packages = with pkgs; [
      hyprshot
      brightnessctl
      wl-clipboard
      wlsunset
      swww
    ];

    home.sessionVariables = let
      inherit (config.xdg) userDirs;
    in
      lib.attrsets.optionalAttrs config.programs.hyprlock.enable {
        "HYPRSHOT_DIR" = userDirs.extraConfig.XDG_SCREENSHOTS_DIR;
      };

    programs.caelestia = {
      enable = setup == "caelestia";
      settings = {
        general = {
          apps = {
            terminal = pkgs.alacritty;
          };
          bar = {
            workspaces = {
              shown = 3;
            };
          };
          session = {
            vimKeybinds = true;
          };
          paths = {
            wallpaperDir = inputs.wallpapers;
          };
        };
        cli.enable = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      plugins = with pkgs.hyprlandPlugins; [
        hyprtrails
        csgo-vulkan-fix
        hyprwinwrap
      ];
      settings = let
        inherit (config.catppuccin) flavor accent;
      in
        {
          "$terminal" = "alacritty";
          "$filemanager" = "alacritty -e yazi";
          "$menu" = "rofi -show drun";

          # TODO - Don't hardcode this
          "monitor" = ",1920x1200@165.00,auto,1";
          "exec-once" =
            [
              "$terminal"
              "wlsunset -S 5:30 -s 18:30"
            ]
            // lib.lists.optionals (setup == "default") [
              "swayosd-server"
              "swww-daemon && sleep 0.1 && swww img ${wallpaper}"
              "waybar"
            ];

          "env" =
            [
              "XCURSOR_SIZE,24"
              "HYPRCURSOR_SIZE,24"
              "HYPRCURSOR_THEME,catppuccin-${flavor}-${accent}-cursors"

              # For Qt
              "QT_AUTO_SCREEN_SCALE_FACTOR,1"
              "QT_QPA_PLATFORM,wayland;xcb"
              "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            ]
            ++ lib.lists.optionals (builtins.elem "nvidia" osConfig.services.xserver.videoDrivers) [
              # Nvidia + Wayland
              "LIBVA_DRIVER_NAME,nvidia"
              "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            ];

          general =
            {
              gaps_in = 5;
              gaps_out = windows_space_gap;
              border_size = 2;

              resize_on_border = false;

              allow_tearing = false;

              layout = "dwindle";
            }
            // lib.attrsets.optionalAttrs (!config.stylix.targets.hyprland.enable) {
              "col.active_border" = "$mauve $flamingo 45deg";
              "col.inactive_border" = "$surface0";
            };

          decoration = {
            rounding = 10;
            active_opacity = 1.0;
            inactive_opacity = 1.0;

            shadow.range = 4;
            shadow.render_power = 3;

            blur = {
              enabled = true;
              size = 3;
              passes = 1;

              vibrancy = 0.1696;
            };
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };
          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          master = {
            new_status = "master";
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
          };

          input = {
            kb_layout = "us";
            kb_variant = "";
            kb_model = "";
            kb_options = "";
            kb_rules = "";

            follow_mouse = 1;

            sensitivity = 0;

            touchpad = {
              natural_scroll = false;
            };
          };
          gestures = {
            workspace_swipe = false;
          };

          device = {
            name = "epic-mouse-v1";
            sensitivity = -0.5;
          };

          plugin = {
            hyprtrails = {
              color =
                if config.catppuccin.hyprland.enable
                then "$accent"
                else if config.stylix.targets.hyprland.enable
                then "rgb(${config.lib.stylix.colors.base0E})"
                else null;
            };
            hyprwinwrap = {
              class = "backgroundapp";
            };
          };
          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          ];
        }
        // (import ./keybinds.nix {inherit config lib setup;});
      xwayland.enable = true;
    };

    programs.waybar = {
      enable = setup == "default";
      style =
        lib.strings.optionalString config.stylix.targets.waybar.enable ''
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
        ''
        + ''
          * {
            color: @text;
            font-family: ${config.stylix.fonts.monospace.name};
            font-weight: bold;
            font-size: 14px;
          }

          window#waybar {
            background-color: rgba(0, 0, 0, 0);
          }

          #waybar > box {
            margin: 10px ${builtins.toString windows_space_gap}px 0px;
            background-color: @base;
            border: 2px solid @mauve;
          }

          #workspaces,
          #window,
          #idle_inhibitor,
          #wireplumber,
          #network,
          #cpu,
          #memory,
          #battery,
          #clock,
          #power-profiles-daemon,
          #tray,
          #waybar > box {
            border-radius: 12px;
          }

          #workspaces * {
            color: @red;
          }

          #window * {
            color: @mauve;
          }

          #clock {
            color: @peach;
          }

          #idle_inhibitor {
            color: @yellow;
          }

          #wireplumber {
            color: @green;
          }

          #network {
            color: @teal;
          }

          #power-profiles-daemon {
            color: @blue;
          }

          #battery {
            color: @lavender;
          }

          #tray {
            color: @text;
          }

          #idle_inhibitor,
          #wireplumber,
          #network,
          #cpu,
          #memory,
          #battery,
          #clock,
          #power-profiles-daemon,
          #tray {
            padding: 0 5px;
          }
        '';

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          spacing = 4;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "idle_inhibitor"
            "wireplumber"
            "network"
            (lib.strings.optionalString osConfig.services.power-profiles-daemon.enable "power-profiles-daemon") # Only enable power-profiles-daemon in waybar if it's enabled in system config
            "battery"
            "tray"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            warp-on-scroll = false;
            format = "{name}: {icon}";
            format-icons = {
              "urgent" = "";
              "active" = "";
              "default" = "";
            };
          };

          idle_inhibitor = {
            format = "Idle: {icon} ";
            format-icons = {
              "deactivated" = "";
              "activated" = "";
            };
          };

          wireplumber = {
            format = "Volume: {icon}  {volume}% ";
            format-icons = ["" "" ""];
            format-muted = "Muted ";
          };

          clock = let
            rosewater = "#f5e0dc";
            lavender = "#b4befe";
            teal = "#99ffdd";
            peach = "#fab387";
            red = "#f38ba8";
          in {
            format = "  {:%H:%M}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                "months" = "<span color='${rosewater}'><b>{}</b></span>";
                "days" = "<span color='${lavender}'><b>{}</b></span>";
                "weeks" = "<span color='${teal}'><b>W{}</b></span>";
                "weekdays" = "<span color='${peach}'><b>{}</b></span>";
                "today" = "<span color='${red}'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              "on-click-right" = "mode";
              "on-scroll-up" = "tz_up";
              "on-scroll-down" = "tz_down";
            };
          };

          network = {
            format = "  {essid} 󰓅 {signalStrength}";
          };

          power-profiles-daemon = {
            format = "Profile: {icon} ";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              default = "";
              performance = "";
              balanced = "";
              power-saver = "";
            };
          };

          battery = {
            format-icons = ["" "" "" "" ""];
            format = "{icon}  {capacity}%";
          };
        };
      };
    };
  };
}
