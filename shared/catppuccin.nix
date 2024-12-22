{config, ...}: {
  catppuccin = {
    enable = !config.stylix.autoEnable;
    flavor = "mocha";
    accent = "mauve";
  };
}
