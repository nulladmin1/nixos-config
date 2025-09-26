{
  lib,
  config,
  inputs,
  ...
}: let
  moduleName = "launcher";
in {
  imports = with inputs; [
    vicinae.homeManagerModules.default
  ];

  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    # stylix.targets.rofi.enable = false;
    # catppuccin.rofi.enable = true;
    # programs.rofi = {
    #   enable = true;
    # };

    services.vicinae = {
      enable = true;
      autoStart = true;
    };
  };
}
