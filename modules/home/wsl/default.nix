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
      sops.enable = true;
      spicetify.enable = true;
      ssh.enable = true;
      terminal.enable = true;
      theming.enable = true;
      wakatime.enable = true;
      xdg.enable = true;
    };
  };
}
