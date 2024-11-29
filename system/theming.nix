{
  inputs,
  config,
  ...
}: let
  inherit (config.var) wallpaper font;
in {
  imports =
    [
      ../shared/theme.nix
    ]
    ++ (with inputs; [
      stylix.nixosModules.stylix
      catppuccin.nixosModules.catppuccin
    ]);

  services.displayManager.sddm.catppuccin = {
    background = wallpaper;
    inherit font;
  };
}
