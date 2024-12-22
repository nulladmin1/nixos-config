{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        shuffle
      ];
    }
    // lib.attrsets.optionalAttrs (!config.stylix.targets.spicetify.enable) {
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
}
