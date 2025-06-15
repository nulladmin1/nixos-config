{
  lib,
  config,
  ...
}: let
  moduleName = "terminal";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.bash = {
      enable = true;
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        h = "history | fzf";
        ":q" = "exit";

        tmp = "dir=$(mktemp -d) && cd $dir";
      };
      initExtra = ''
        nerdfetch
      '';
    };

    # Alacritty
    programs.alacritty = {
      enable = true;
      settings = {
        window =
          {
            blur = true;
          }
          // lib.attrsets.optionalAttrs (!config.stylix.targets.alacritty.enable) {
            opacity = 0.9;
          };
        font = {
          normal = {
            family = config.stylix.fonts.monospace.name;
            style = "Regular";
          };
        };
      };
    };

    programs.starship.enable = true;

    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
      enableBashIntegration = true;
    };

    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        show_startup_tips = false;
      };
    };

    programs.fastfetch = {
      enable = true;
    };

    programs.btop = {
      enable = true;
    };

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    programs.yazi = {
      enable = true;
    };

    programs.tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    programs.eza = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
