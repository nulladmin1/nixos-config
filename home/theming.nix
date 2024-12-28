{
  config,
  osConfig,
  lib,
  ...
}: {
  catppuccin = {
    cursors = {
      enable = false;
    };

  qt = let
    osTheme = osConfig.qt.platformTheme;
  in {
    inherit (osConfig.qt) enable;
    platformTheme.name =
      if config.catppuccin.kvantum.enable
      then "kvantum"
      else if osTheme == "gtk2"
      then "gtk"
      else osTheme;
    style = lib.mkIf config.catppuccin.kvantum.enable {
      name = "kvantum";
    };
  };
}
