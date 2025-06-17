{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.custom.common.enable {
    custom = {
      ghostty.enable = true;
      ghostwriter.enable = true;
      git.enable = true;
      helix.enable = true;
      hyprland.enable = true;
      packages.enable = true;
      sops.enable = true;
      spicetify.enable = true;
      ssh.enable = true;
      terminal.enable = true;
      theming.enable = true;
      vscode.enable = true;
      wakatime.enable = true;
      xdg.enable = true;
    };
  };
}
