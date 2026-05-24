{
  lib,
  pkgs,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.custom.common.enable {
    custom = {
      apps.enable = true;
      awww.enable = true;
      ghostwriter.enable = true;
      git.enable = true;
      helix.enable = true;
      launcher.enable = true;
      noctalia.enable = true;
      spicetify.enable = true;
      ssh.enable = true;
      terminal.enable = true;
      vscode.enable = true;
      wakatime.enable = true;
      xdg.enable = true;
      zed.enable = true;

      niri.enable = osConfig.custom.niri.enable;
    };

    programs.home-manager = {
      enable = true;
    };

    home = {
      stateVersion = "24.05";
      homeDirectory = "/home/shreyd";

      sessionVariables = {
        EDITOR = "hx";
        GTK_USE_PORTAL = "1";
      };
    };
  };
}
