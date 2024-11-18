{
  config,
  pkgs,
  ...
}: {
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };

  # SANE
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.hplipWithPlugin];
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

  # List services that you want to enable:
  services.fwupd.enable = true;

  programs.command-not-found.enable = false;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [hplipWithPlugin];
  };

  # Avahi for printing
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.gamemode.enable = true;

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
