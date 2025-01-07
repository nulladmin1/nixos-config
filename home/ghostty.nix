{
  pkgs,
  inputs,
  config,
  ...
}: {
  # TODO - figure out ghostty keybinding syntax
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.system}.default;

    settings = {
      theme = "catppuccin-${config.catppuccin.flavor}";
      font-family = config.stylix.fonts.monospace.name;
      background-opacity = builtins.toString config.stylix.opacity.terminal;

      window-theme = "system";

      # Keybinds
      #keybind = [
      #  "ctrl+p>n=new_split"
      #
      #  "ctrl+p>up=goto_split:top"
      #  "ctrl+p>down=goto_split:bottom"
      #  "ctrl+p>left=goto_split:left"
      #  "ctrl+p>right=goto_split:right"

      #  "ctrl+t>n=new_tab"

      #  "ctrl+t>w=new_window"
      #  "ctrl+t>o=toggle_tab_overview"
      #];
    };

    clearDefaultKeybinds = true;
  };
}
