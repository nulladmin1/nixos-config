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
        nixd # Nix
        kdePackages.qtdeclarative # qmlls for QML
        inputs.wakatime-ls.packages.${pkgs.system}.default # Wakatime integration

        simple-completion-language-server # Snippets and stuff

        # Formatters
        alejandra # Nix
        nodePackages_latest.prettier # Web stuff
        zig # Zig
      ];

      # Language configuration
      languages = {
        language = let
          prettier = getExe pkgs.nodePackages.prettier;
          commonLsp = ["wakatime" "scls"];
        in [
          {
            name = "nix";
            formatter = {
              command = "alejandra";
            };
            auto-format = true;

            language-servers = ["nixd"] ++ commonLsp;
          }
          {
            name = "c";
            language-servers = ["clangd"] ++ commonLsp;
          }
          {
            name = "cpp";
            language-servers = ["clangd"] ++ commonLsp;
          }
          {
            name = "cmake";
            language-servers = ["cmake-language-server"] ++ commonLsp;
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
            language-servers = ["emmet-ls"] ++ commonLsp;
          }
          {
            name = "css";
            language-servers = ["emmet-ls"] ++ commonLsp;
            formatter = {
              command = prettier;
              args = ["--parser" "css"];
            };
          }
          {
            name = "markdown";
            language-servers = ["marksman"] ++ commonLsp;
            formatter = {
              command = prettier;
              args = ["--parser" "markdown"];
            };
          }
          {
            name = "python";
            language-servers = ["ty" "ruff" "jedi" "pylsp"] ++ commonLsp;
          }
          {
            name = "rust";
            language-servers = ["rust-analyzer"] ++ commonLsp;
          }
          {
            name = "javascript";
            language-servers = ["typescript-language-server"] ++ commonLsp;
          }
          {
            name = "java";
            language-servers = ["jdtls"] ++ commonLsp;
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

          scls = {
            command = "simple-completion-language-server";
            config = {
              feature_words = true;
              feature_snippets = true;
              snippets_first = true;
              feature_paths = true;
              feature_unicode_input = true;
            };
            environment = {
              RUST_LOG = "info,simple-completion-language-server=info";
              LOG_FILE = "/tmp/completion.log";
            };
          };

          wakatime = {
            command = "wakatime-ls";
          };
        };
      };
    };
    home.file.".config/helix/external-snippets.toml".source = (pkgs.formats.toml {}).generate "snippets" {
      sources = [
        {
          name = "friendly-snippets";
          git = "https://github.com/rafamadriz/friendly-snippets.git";
          paths = [
            {
              scope = ["bash"];
              path = "snippets/shell/";
            }
            {
              scope = ["c"];
              path = "snippets/c/";
            }
            {
              scope = ["cmake"];
              path = "snippets/cmake.json";
            }
            {
              scope = ["cpp"];
              path = "snippets/cpp/";
            }
            {
              scope = ["dart"];
              path = "snippets/dart.json";
            }
            {
              scope = ["dart"];
              path = "snippets/frameworks/flutter.json";
            }
            {
              scope = ["dockerfile"];
              path = "snippets/docker/docker_file.json";
            }
            {
              scope = ["docker-compose"];
              path = "snippets/docker/docker-compose.json";
            }
            {
              scope = ["git-commit"];
              path = "snippets/gitcommit.json";
            }
            {
              scope = ["go"];
              path = "snippets/go.json";
            }
            {
              scope = ["haskell"];
              path = "snippets/haskell.json";
            }
            {
              scope = ["html"];
              path = "snippets/html.json";
            }
            {
              scope = ["java"];
              path = "snippets/java";
            }
            {
              scope = ["javascript"];
              path = "snippets/javascript/javascript.json";
            }
            {
              scope = ["markdown"];
              path = "snippets/markdown.json";
            }
            {
              scope = ["nix"];
              path = "snippets/nix.json";
            }
            {
              scope = ["python"];
              path = "snippets/python/";
            }
            {
              scope = ["rust"];
              path = "snippets/rust/";
            }
            {
              scope = ["python" "rust" "go" "c" "cpp" "java"];
              path = "snippets/loremipsum.json";
            }
          ];
        }
      ];
    };
  };
}
