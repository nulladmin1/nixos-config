{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  moduleName = "theming";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.stylix.nixosModules.stylix
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    stylix = {
      enable = true;
      autoEnable = false;
      polarity = "dark";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${config.catppuccin.flavor}.yaml";

      cursor = let
        capitalize = let
          inherit (lib.strings) toUpper substring;
        in
          str: toUpper (substring 0 1 str) + substring 1 (builtins.stringLength str) str;

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
        regreet.enable = true;
      };

      opacity = {
        terminal = 0.9;
      };
    };

    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "mauve";
    };
  };
}
