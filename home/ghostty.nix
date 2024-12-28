{
  pkgs,
  inputs,
  config,
  ...
}: let
  configFile = config.xdg.configHome + "/ghostty/config";
in {
  home.packages = with inputs; [
    ghostty.packages.${pkgs.system}.default
  ];

  home.file.${configFile}.text = ''
    theme = catppuccin-${config.catppuccin.flavor}
    font-family = ${config.stylix.fonts.monospace.name}
    background-opacity = ${builtins.toString config.stylix.opacity.terminal}
    window-theme = system
  '';
}
