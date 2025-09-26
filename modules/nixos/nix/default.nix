{
  lib,
  config,
  inputs,
  ...
}: let
  moduleName = "nix";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    nix = {
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
      settings = let
      in {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        substituters = [
          "https://hyprland.cachix.org"
          "https://nix-community.cachix.org"
          "https://cuda-maintainers.cachix.org"
          "https://vicinae.cachix.org"
        ];
        trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
          "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        ];
      };
    };
  };
}
