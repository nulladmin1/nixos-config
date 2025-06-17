{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.custom.wsl.enable {
    custom = {
      ghostty.enable = true;
      ghostwriter.enable = true;
      git.enable = true;
      helix.enable = true;
      spicetify.enable = true;
      ssh.enable = true;
      terminal.enable = true;
      wakatime.enable = true;
      vscode.enable = true;
      xdg.enable = true;
    };
  };
}
