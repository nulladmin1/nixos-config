{ wallpaper, ... }:
{
  programs.rofi = {
    enable = true;
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
