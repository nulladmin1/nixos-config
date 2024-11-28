{
  inputs,
  pkgs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
