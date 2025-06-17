{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.custom.common.enable {
    custom = {
      apps.enable = true;
      ghostty.enable = true;
      ghostwriter.enable = true;
      git.enable = true;
      helix.enable = true;
      spicetify.enable = true;
      ssh.enable = true;
      terminal.enable = true;
      vscode.enable = true;
      wakatime.enable = true;
      xdg.enable = true;
    };
  };
}
