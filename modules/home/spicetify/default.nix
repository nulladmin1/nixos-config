{
  lib,
  config,
  inputs,
  system,
  ...
}: let
  moduleName = "spicetify";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
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
  };
}
