{
  pkgs,
  wallpaper,
  inputs,
  system,
  ...
}: {
  services.swaync = {
    enable = true;
    style = let
      theme = builtins.fetchurl {
        url = "https://github.com/catppuccin/swaync/releases/download/v0.2.3/macchiato.css";
        sha256 = "1cyiblyarslbjjnrd6yysm75fy8v0nfacacnizhg697md6fvmj9c";
      };
    in
      builtins.readFile "${theme}";
  };

  programs.rofi = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
  };

  services.swayosd.enable = true;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${wallpaper}";
      wallpaper = ", ${wallpaper}";
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
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

  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        monitor = "";
        path = "${wallpaper}";
        blur_passes = 2;
      };

      input-field = {
        monitor = "";
        size = "80px, 60px";
        outline_thickness = 3;
        inner_color = "$base";

        outer_color = "$accent";
        check_color = "$accent";
        fail_color = "$red";

        font_color = "$text";
        fade_on_empty = false;
        rounding = 15;

        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${system}.hyprland;
    plugins = with inputs.hyprland-plugins.packages.${system}; [
      hyprtrails
      csgo-vulkan-fix
      hyprwinwrap
    ];
    settings = {
      "$terminal" = "alacritty";
      "$filemanager" = "yazi";
      "$menu" = "rofi -show drun";

      "monitor" = ",1920x1200@165.00,auto,1";
      "exec-once" = [
        "$terminal"
        "waybar"
        "wlsunset -S 5:30 -s 18:30"
        "hyprpaper"
        "swayosd-server"
      ];

      "env" = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"

        # For Qt
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt6ct"

        # Nvidia + Wayland
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        "col.active_border" = "$mauve $flamingo 45deg";
        "col.inactive_border" = "$surface0";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
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
          color = "$accent";
        };
        hyprwinwrap = {
          class = "backgroundapp";
        };
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, W, killactive,"
        "$mainMod CTRL, Q, exit,"
        "$mainMod, E, exec, $terminal -e $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, F, fullscreen, 1"
        ", Print, exec, hyprshot -m region"
        "$mainMod, Print, exec, hyprshot -m output"

        "$mainMod, L, exec, hyprlock"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
    xwayland.enable = true;
  };

  #programs.cava = {
  #  enable = true;
  #  settings = {
  #    general = {
  #      mode = "normal";
  #      framerate = 60;
  #      bars = 0;
  #      bar_width = 2;
  #      bar_spacing = 1;
  #      bar_height = 32;
  #    };
  #    input = {
  #      method = "pipewire";
  #      source = "auto";
  #    };
  #  };
  #};

  programs.waybar = {
    enable = true;
    style = ''
      * {
        color: @text;
        font-family: JetBrainsMono Nerd Font;
        font-weight: bold;
        font-size: 14px;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0);
      }

      #waybar > box {
        margin: 10px 15px 0px;
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

      #idle_inhibitor {
        color: @peach;
      }

      #window * {
        color: @mauve;
      }

      #wireplumber {
        color: @yellow;
      }

      #network {
        color: @green;
      }

      #power-profiles-daemon {
        color: @teal;
      }

      #battery {
        color: @blue;
      }

      #clock {
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
        ];
        modules-right = [
          "idle_inhibitor"
          "wireplumber"
          "network"
          "power-profiles-daemon"
          "battery"
          "clock"
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

        #cava = {
        #  cava_config = "$HOME/.config/cava/config";
        #  framerate = 60;
        #  bars = 16;
        #  method = "pipewire";
        #  format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        #  bar_delimiter = 0;
        #};

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

        clock = {
          format = "  {:%H:%M}";
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
}
