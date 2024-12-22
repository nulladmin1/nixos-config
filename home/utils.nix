{
  lib,
  config,
  ...
}: {
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

  # KDEConnect
  # services.kdeconnect.enable = true;

  # Neovim:
  programs.neovim = {
    enable = false;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.thefuck = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    settings = {
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

  services.playerctld.enable = true;
}
