{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  moduleName = "noctalia";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.noctalia-shell = {
      enable = true;
    };

    home.packages = with pkgs; [
      imagemagick

      # Screen Toolkit
      grim
      slurp
      tesseract
      zbar
      jq
      wl-screenrec
      python3
      python3Packages.pygobject3
      hyprpicker
      translate-shell
      gifski

      # Wallcards
      mpvpaper
    ];
  };
}
