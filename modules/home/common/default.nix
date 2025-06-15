{
  lib,
  config,
  ...
}: {
  options.custom.home = {
    enable = lib.options.mkEnableOption "home";
  };
  config = lib.mkIf config.custom.home.enable {
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
      vscode.enable = true;
      wakatime.enable = true;
      xdg.enable = true;
    };
  };
}
