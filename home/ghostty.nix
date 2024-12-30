{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  configFile = config.xdg.configHome + "/ghostty/config";
  inherit (lib.strings) optionalString;
in {
  home.packages = with inputs; [
    ghostty.packages.${pkgs.system}.default
  ];
  # TODO - figure out ghostty keybinding syntax
  home.file.${configFile}.text =
    ''
      theme = catppuccin-${config.catppuccin.flavor}
      font-family = ${config.stylix.fonts.monospace.name}
      background-opacity = ${builtins.toString config.stylix.opacity.terminal}
      window-theme = system
    ''
    + optionalString (!config.programs.zellij.enableBashIntegration) ''

      # Zellij-compliant keybinds

      # Split related stuff
      keybind = ctrl+p>n=new_split

      # Split navigation
      keybind = ctrl+p>up=goto_split:top
      keybind = ctrl+p>down=goto_split:bottom
      keybind = ctrl+p>left=goto_split:left
      keybind = ctrl+p>right=goto_split:right

      # Tab-related stuff
      keybind = ctrl+t>n=new_tab

      # Window-related stuff (inherits same leader key as Tab)
      keybind = ctrl+t>w=new_window
      keybind = ctrl+t>o=toggle_tab_overview
    '';
}
