{ wallpaper, ... }:
{
  services.swaync = {
    enable = true;
  };

  programs.rofi = {
    enable = true;
  };

  programs.yazi = {
    enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$filemanager" = "yazi";
      "$menu" = "rofi -show drun";
      
      "monitor" = "eDP-1,1920x1200@165.00,auto,1";
      "exec-once" = "$terminal & waybar & swaybg -i ${wallpaper}";
      
      "env" = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      
    
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
        "$mainMod, F, fullscreen"
        ", Print, exec, hyprshot -m region"
        "$mainMod, Print, exec, hyprshot -m output"

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
  
      bindm =[
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

  programs.cava = {
    enable = true;
    settings = {
      general = {
        mode = "normal";
        framerate = 60;
        bars = 0;
        bar_width = 2;
        bar_spacing = 1;
        bar_height = 32;
      };
      input = {
        method = "pipewire";
        source = "auto";
      };
    };
  };
  
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
        background-color: alpha(@base, 0.7);
        border-radius: 10px;
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
      #tray {
        background-color: @surface0;
        border-radius: 16px;
      }

      #workspaces * {
        color: @red;
      }

      #window * {
        padding: 0 8px;
        color: @mauve;
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
        color: @peach;
        padding: 0 5px;
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
      
      #cpu {
        color: @sky;
      }

      #memory {
        color: @sapphire;
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

      #waybar > box {
        border: 4px solid @base;
        border-radius: 10px;
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
          "cpu"
          "memory"
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
          format-icons = [ "" "" "" ];
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

        cpu = {
          format = " {usage}%";
        };

        memory = {
          format = "{used}Gb  ";
        };

        battery = {
          format-icons = ["" "" "" "" ""];
          format = "{icon}  {capacity}%";
        };
      };
    };
  };
}
