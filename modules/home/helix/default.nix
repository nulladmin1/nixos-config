{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (lib) getExe;
  moduleName = "helix";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    # Integrate Yazi in Helix using Zellij (https://yazi-rs.github.io/docs/tips/#helix-with-zellij)
    home.file.".config/helix/yazi-picker.sh" = {
      executable = true;

      text = ''
        #!/usr/bin/env bash
        paths=$(yazi "$2" --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)
        if [[ -n "$paths" ]]; then
          zellij action toggle-floating-panes
          zellij action write 27 # send <Escape> key
          zellij action write-chars ":$1 $paths"
          zellij action write 13 # send <Enter> key
        else
          zellij action toggle-floating-panes
        fi
      '';
    };

    programs.helix = {
      enable = true;

      settings = {
        theme = "catppuccin-transparent";
        editor = {
          bufferline = "always";
          cursor-shape.insert = "bar";
          color-modes = true;

          lsp = {
            display-inlay-hints = true;
          };
        };

        # Integrate Yazi in Helix using Zellij
        keys.normal = {
          space.space = ":sh zellij run -n Yazi -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- bash ~/.config/helix/yazi-picker.sh open %{buffer_name}";
        };
      };

      themes = {
        catppuccin-transparent = let
          inherit (config.catppuccin) flavor;

          theme =
            lib.importTOML "${inputs.catppuccin-helix}/themes/default/catppuccin_${flavor}.toml";

          patchedTheme =
            (builtins.removeAttrs theme ["ui.background"])
            // {
              ui.background = {};
            };
        in
          patchedTheme;
      };

      extraPackages = with pkgs; [
        # LSP
        bash-language-server # Bash
        cmake-language-server # Cmake
        emmet-ls # Emmet Language Server
        libclang # Clangd
        marksman # Markdown
        ruff # Python
        gopls # Go
        vscode-langservers-extracted # Html, CSS, Eslint, JSON, and Markdown LSPs (not all used)
        hyprls # Hyprland Config
        taplo # Toml
        zls # Zig
        kdePackages.qtdeclarative # qmlls for QML

        # Formatters
        alejandra # Nix
        nodePackages_latest.prettier # Web stuff
        zig # Zig
      ];

      # Language configuration
      languages = {
        language = let
          prettier = getExe pkgs.nodePackages.prettier;
        in [
          {
            name = "nix";
            formatter = {
              command = "alejandra";
            };
            auto-format = true;

            language-servers = ["nil"];
          }
          {
            name = "cmake";
            formatter = {
              command = getExe pkgs.cmake-lint;
            };
          }
          {
            name = "jsonc";
            formatter = {
              command = prettier;
              args = ["--parser" "json"];
            };
          }
          {
            name = "html";
            formatter = {
              command = prettier;
              args = ["--parser" "html"];
            };
            language-servers = ["emmet-ls"];
          }
          {
            name = "css";
            language-servers = ["emmet-ls"];
            formatter = {
              command = prettier;
              args = ["--parser" "css"];
            };
          }
          {
            name = "markdown";
            formatter = {
              command = prettier;
              args = ["--parser" "markdown"];
            };
          }
        ];
        language-server = {
          rust-analyzer = {
            config.check.command = "clippy";
          };

          emmet-ls = {
            command = "${pkgs.emmet-ls}/bin/emmet-ls";
            args = ["stdio"];
          };
        };
      };
    };
  };
}
