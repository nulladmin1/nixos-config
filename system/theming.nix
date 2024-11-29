{inputs, ...}: {
  imports =
    [
      ../shared/theme.nix
    ]
    ++ (with inputs; [
      stylix.nixosModules.stylix
      catppuccin.nixosModules.catppuccin
    ]);
}
