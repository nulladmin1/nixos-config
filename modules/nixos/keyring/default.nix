{
  lib,
  config,
  ...
}: {
  options.custom.gnome-keyring = {
    enable = lib.options.mkEnableOption "gnome-keyring";
  };

  config = lib.mkIf config.custom.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services = {
      greetd.enableGnomeKeyring = true;
    };
    programs.seahorse.enable = true;
  };
}
