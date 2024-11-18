{
  config,
  pkgs,
  ...
}: {
  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.command-not-found.enable = false;

  # ADB
  programs.adb.enable = true;

  # Enable redshift for night light
  #services.redshift = {
  #  enable = true;
  #  brightness = {
  #    day = "1";
  #    night = "1";
  #  };
  #  temperature = {
  #    night = 25000;
  #  };
  #};
}
