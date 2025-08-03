{
  lib,
  config,
  ...
}: let
  moduleName = "common";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    custom = {
      audio.enable = true;
      fonts.enable = true;
      greetd.enable = true;
      gnome.enable = true;
      hardware.enable = true;
      hyprland.enable = true;
      kdeconnect.enable = true;
      locales.enable = true;
      nh.enable = true;
      nix.enable = true;
      packages.enable = true;
      printing.enable = true;
      sops.enable = true;
      theming.enable = true;
      users.enable = true;
      utils.enable = true;
      virtualisation.enable = true;
      xdg-portal.enable = true;
    };
  };
}
