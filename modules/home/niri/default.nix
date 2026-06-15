{
  lib,
  pkgs,
  config,
  ...
}: let
  moduleName = "niri";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.niri.settings = {
      input = {
        keyboard = {
          xkb = {
            # You can set rules, model, layout, variant and options.
            # For more information, see xkeyboard-config(7).

            # For example:
            # layout "us,ru"
            # options "grp:win_space_toggle,compose:ralt,ctrl:nocaps"

            # If this section is empty, niri will fetch xkb settings
            # from org.freedesktop.locale1. You can control these using
            # localectl set-x11-keymap.
          };

          # Enable numlock on startup, omitting this setting disables it.
          numlock = true;
        };

        # Next sections include libinput settings.
        # Omitting settings disables them, or leaves them at their default values.
        # commented-out settings here are examples, not defaults.
        touchpad = {
          tap = true;
          accel-profile = "flat";
        };

        mouse = {
          accel-profile = "flat";
        };

        # Uncomment this to make the mouse warp to the center of newly focused windows.
        warp-mouse-to-focus.enable = true;

        # Focus windows and outputs automatically when moving the mouse into them.
        # Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
        focus-follows-mouse.max-scroll-amount = "0%";
      };

      # Blurred Overview with Noctalia.
      layer-rules = [
        {
          matches = [
            {namespace = "^noctalia-overview*";}
          ];

          place-within-backdrop = true;
        }
      ];

      # Settings that influence how windows are positioned and sized.
      layout = {
        # Gaps around windows in logical pixels.
        gaps = 12;

        # When to center a column when changing focus:
        # "never", "always", or "on-overflow".
        center-focused-column = "never";

        # Widths that switch-preset-column-width cycles through.
        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
          # { fixed = 1920; }
        ];

        # Default width of new windows.
        # Leave empty if you want windows to decide their own initial width.
        default-column-width = {
          proportion = 0.66667;
        };

        # Focus ring around the active window.
        focus-ring = {
          # enable = false;
          enable = true;

          # How many logical pixels the ring extends out from windows.
          width = 4;

          # Color of the ring on the active monitor.
          active.color = "#cba6f7";

          # Color of the ring on inactive monitors.
          inactive.color = "#505050";

          # You can use gradients instead of solid colors if wanted.
          # active.gradient = {
          #   from = "#80c8ff";
          #   to = "#c7ff7f";
          #   angle = 45;
          # };
        };

        # Border around windows.
        # Since this is off, focus-ring is doing the visible active outline.
        border = {
          enable = false;

          width = 4;
          active.color = "#ffc87f";
          inactive.color = "#505050";

          # Color for windows requesting attention.
          urgent.color = "#9b0000";
        };

        # Drop shadows for windows.
        shadow = {
          # Your original config had shadow settings but did not enable shadows.
          # Set enable = true if you want them.
          enable = false;

          # Softness controls the shadow blur radius.
          softness = 30;

          # Spread expands the shadow.
          spread = 5;

          # Offset moves the shadow relative to the window.
          offset = {
            x = 0;
            y = 5;
          };

          # Shadow color and opacity.
          color = "#0007";
        };

        # Struts shrink the area occupied by windows.
        # Similar to extra outer gaps.
        struts = {
          # left = 64;
          # right = 64;
          # top = 64;
          # bottom = 64;
        };
      };

      # Startup processes.
      # Running Niri as a session also supports xdg-desktop-autostart.
      spawn-at-startup = [
        {argv = ["alacritty"];}
        {argv = ["swayosd-server"];}
        {argv = ["wlsunset" "-S" "5:30" "-s" "18:30"];}
        {argv = ["noctalia-shell"];}
        {argv = ["bitwarden"];}
      ];

      hotkey-overlay = {
        # Disable the Important Hotkeys popup at startup.
        # skip-at-startup = true;
      };

      # Ask clients to omit client-side decorations when possible.
      # This can make borders/rings/rounded corners look better.
      # Restart apps after changing this.
      prefer-no-csd = true;

      # Screenshot save path.
      # strftime-style formatting is supported.
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # Set to null to disable saving screenshots to disk.
      # screenshot-path = null;

      # Animation settings.
      animations = {
        # Set enable = false to turn off all animations.
        enable = true;

        # Slow down all animations by this factor.
        # Values below 1 speed them up.
        # slowdown = 3.0;
      };

      environment = {
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";

        GDK_BACKEND = "wayland,x11";

        # Helps Chromium/Electron apps prefer Wayland on NixOS.
        NIXOS_OZONE_WL = "1";

        GTK_USE_PORTAL = null;

        QT_QPA_PLATFORMTHEME = "qtct";
      };

      # Window rules.
      window-rules = [
        {
          matches = [
            {
              app-id = "brave-browser$";
              title = "^Picture-in-Picture$";
            }
          ];

          open-floating = true;
        }
        {
          matches = [
            {
              app-id = "^brave-.+-.+$";
              title = "^Bitwarden$";
            }
          ];

          open-floating = true;
          open-focused = true;
        }

        # TODO: Alacritty blur.
        #{
        #  matches = [
        #    {
        #      app-id = "^Alacritty$";
        #    }
        #  ];

        #  background-effect = {
        #    blur = true;
        #  };
        # }

        # Enable rounded corners for all windows.
        {
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };

          clip-to-geometry = true;
        }

        # Transparency fix.
        {
          draw-border-with-background = false;
        }

        # Example: block out password managers from screen capture.
        # {
        #   matches = [
        #     { app-id = "^org\\.keepassxc\\.KeePassXC$"; }
        #     { app-id = "^org\\.gnome\\.World\\.Secrets$"; }
        #   ];
        #
        #   block-out-from = "screen-capture";
        #
        #   # Use this instead if you want them visible on screenshots
        #   # but hidden from third-party screen sharing tools.
        #   # block-out-from = "screencast";
        # }
      ];

      binds = {
        # Mod-Shift-/, usually the same as Mod-?, shows the hotkey overlay.
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];

        "Mod+Return" = {
          hotkey-overlay = {title = "Open a Terminal: alacritty";};
          action.spawn = "alacritty";
        };

        "Mod+R" = {
          hotkey-overlay = {title = "Run Vicinae";};
          action.spawn = ["vicinae" "toggle"];
        };

        "Mod+Shift+R" = {
          hotkey-overlay = {title = "Run Noctalia Launcher";};
          action.spawn = ["sh" "-c" "noctalia-shell ipc call launcher toggle"];
        };

        # Lock screen using Noctalia.
        "Mod+L" = {
          hotkey-overlay = {title = "Lock Screen";};
          action.spawn = ["noctalia-shell" "ipc" "call" "lockScreen" "lock"];
        };

        # Volume using Noctalia.
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = ["noctalia-shell" "ipc" "call" "volume" "increase"];
        };

        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = ["noctalia-shell" "ipc" "call" "volume" "decrease"];
        };

        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = ["noctalia-shell" "ipc" "call" "volume" "muteOutput"];
        };

        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = ["sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"];
        };

        # Media keys using playerctl.
        # Works with any MPRIS-enabled media player.
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn = ["sh" "-c" "playerctl play-pause"];
        };

        "XF86AudioStop" = {
          allow-when-locked = true;
          action.spawn = ["sh" "-c" "playerctl stop"];
        };

        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn = ["sh" "-c" "playerctl previous"];
        };

        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn = ["sh" "-c" "playerctl next"];
        };

        # Brightness using Noctalia.
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "increase"];
        };

        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "decrease"];
        };

        # Open/close overview.
        "Mod+O" = {
          repeat = false;
          action.toggle-overview = [];
        };

        "Mod+W" = {
          repeat = false;
          action.close-window = [];
        };

        # Focus windows/columns.
        "Mod+Left".action.focus-column-left = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+Right".action.focus-column-right = [];

        # Alternative vim-style binds:
        # "Mod+H".action.focus-column-left = [];
        # "Mod+J".action.focus-window-down = [];
        # "Mod+K".action.focus-window-up = [];
        # "Mod+L".action.focus-column-right = [];

        # Move windows/columns.
        "Mod+Ctrl+Left".action.move-column-left = [];
        "Mod+Ctrl+Down".action.move-window-down = [];
        "Mod+Ctrl+Up".action.move-window-up = [];
        "Mod+Ctrl+Right".action.move-column-right = [];

        # First/last column.
        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];

        # Focus monitors.
        "Mod+Shift+Left".action.focus-monitor-left = [];
        "Mod+Shift+Down".action.focus-monitor-down = [];
        "Mod+Shift+Up".action.focus-monitor-up = [];
        "Mod+Shift+Right".action.focus-monitor-right = [];

        # Move columns to monitors.
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];

        # Workspace focus.
        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+U".action.focus-workspace-down = [];
        "Mod+I".action.focus-workspace-up = [];

        # Move columns between workspaces.
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

        # Move workspace itself.
        "Mod+Shift+Page_Down".action.move-workspace-down = [];
        "Mod+Shift+Page_Up".action.move-workspace-up = [];
        "Mod+Shift+U".action.move-workspace-down = [];
        "Mod+Shift+I".action.move-workspace-up = [];

        # Mouse wheel workspace switching.
        # cooldown-ms avoids scrolling through workspaces too fast.
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = [];
        };

        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = [];
        };

        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = [];
        };

        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = [];
        };

        # Horizontal column scrolling.
        "Mod+WheelScrollRight".action.focus-column-right = [];
        "Mod+WheelScrollLeft".action.focus-column-left = [];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];

        # Shift-wheel equivalents.
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];

        # Workspace indices.
        # Niri has dynamic workspaces, so these are best-effort.
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # Consume/expel windows from columns.
        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];

        # Consume one window from the right into the focused column.
        "Mod+Comma".action.consume-window-into-column = [];

        # Expel the bottom window from the focused column to the right.
        "Mod+Period".action.expel-window-from-column = [];

        # Column/window sizing.
        "Mod+J".action.switch-preset-column-width = [];
        "Mod+H".action.switch-preset-window-height = [];
        "Mod+Ctrl+H".action.reset-window-height = [];

        "Mod+F".action.maximize-column = [];
        "Mod+M".action.fullscreen-window = [];

        # Expand focused column to available width.
        "Mod+Ctrl+F".action.expand-column-to-available-width = [];

        "Mod+C".action.center-column = [];
        "Mod+Ctrl+C".action.center-visible-columns = [];

        # Finer width adjustments.
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Finer height adjustments.
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Floating/tiling.
        "Mod+V".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];

        # Screenshots.
        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];

        # Escape hatch for apps that inhibit compositor shortcuts.
        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [];
        };

        # Quit Niri. This shows a confirmation dialog.
        "Mod+Ctrl+Q".action.quit = [];
        "Ctrl+Alt+Delete".action.quit = [];

        # Power off monitors.
        "Mod+Shift+P".action.power-off-monitors = [];
      };
    };
    stylix.targets.niri.enable = false;

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.niri = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        "org.freedesktop.impl.portal.OpenURI" = ["gtk"];
        "org.freedesktop.impl.portal.Settings" = ["gtk"];

        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        "org.freedesktop.impl.portal.RemoteDesktop" = ["gnome"];
      };
    };
  };
}
