{
  lib,
  config,
  inputs,
  system,
  ...
}: let
  moduleName = "rofi";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
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
