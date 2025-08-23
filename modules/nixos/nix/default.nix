{
  lib,
  config,
  ...
}: let
  moduleName = "nix";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = let
    cachixSubstituters = caches: map (cache: "https://${cache}.cachix.org") caches;
    cachixKeys = caches: keys: lib.lists.zipListsWith (cache: key: "${cache}.cachix.org-1:${key}") caches keys;
  in
    lib.mkIf config.custom.${moduleName}.enable {
      nix.settings = {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        substituters = cachixSubstituters [
          "hyprland"
          "nix-community"
          "cuda-maintainers"
        ];
        trusted-public-keys =
          cachixKeys [
            "hyprland"
            "nix-community"
            "cuda-maintainers"
          ] [
            "a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
          ];
      };
    };
}
