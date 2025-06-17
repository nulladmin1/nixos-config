{
  lib,
  config,
  ...
}: let
  moduleName = "nh";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d";
      };
      # TODO
      flake = "/home/shreyd/nixos-config";
    };
  };
}
