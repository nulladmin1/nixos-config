{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "fonts";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    fonts.packages = with pkgs;
      [
        fira-code
        fira-code-symbols
        font-awesome
      ]
      ++ (with pkgs.nerd-fonts; [
        jetbrains-mono
      ]);
    fonts.fontDir.enable = true;
  };
}
