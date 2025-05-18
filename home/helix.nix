{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  rust-toolchain = pkgs.fenix.stable;
in {
  programs.helix = {
    enable = true;

    settings = {
      editor = {
        bufferline = "always";
        cursor-shape.insert = "bar";
        color-modes = true;

        lsp = {
          display-inlay-hints = true;
        };
      };
    };

    extraPackages =
      (with pkgs; [
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

        # Formatters
        alejandra # Nix
        nodePackages_latest.prettier # Web stuff
        zig # Zig
      ])
      ++ (with rust-toolchain; [
        # LSP
        rust-analyzer

        # Formatters
        rustfmt
        clippy
      ]);

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
}
