{
  lib,
  config,
  ...
}: let
  moduleName = "ghostty";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        theme = "catppuccin-${config.catppuccin.flavor}";
        font-family = config.stylix.fonts.monospace.name;
        background-opacity = builtins.toString config.stylix.opacity.terminal;

        window-theme = "system";
      };
    };
  };
}
