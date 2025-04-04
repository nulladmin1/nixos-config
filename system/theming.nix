{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  inherit (config.var) wallpaper;
  font = config.stylix.fonts.monospace.name;
in {
  imports = with inputs; [
    stylix.nixosModules.stylix
    catppuccin.nixosModules.catppuccin
  ];

  stylix = {
    enable = true;
    autoEnable = false;
    image = wallpaper;

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";

    cursor = let
      inherit (lib.customLib) capitalize;
      inherit (config.catppuccin) flavor accent;
    in {
      package = pkgs.catppuccin-cursors.${flavor + (capitalize accent)};
      name = "catppuccin-${flavor}-${accent}-cursors";
      size = 24;
    };

    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };

    targets = {
      gnome.enable = true;
      gtk.enable = true;
      feh.enable = true;
    };

    opacity = {
      terminal = 0.9;
    };
  };

  qt = lib.mkIf (!config.services.desktopManager.plasma6.enable) {
    enable = true;
    platformTheme = "gtk2";
  };

  catppuccin = {
    enable = !config.stylix.autoEnable;
    flavor = "mocha";
    accent = "mauve";
  };

  # TODO
  catppuccin.sddm = {
    enable = false;
    background = wallpaper;
    inherit font;
  };
}
