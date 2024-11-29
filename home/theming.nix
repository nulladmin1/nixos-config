{inputs, ...}: {
  imports =
    [
      ../shared/theme.nix
    ]
    ++ (with inputs; [
      catppuccin.homeManagerModules.catppuccin
      stylix.homeManagerModules.stylix
    ]);
}
