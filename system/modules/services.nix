{ config, pkgs, ... }:

{
    # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Enable WireShark
  programs.wireshark.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };

  services.vscode-server = {
    enable = true;
  };

  programs.command-not-found.enable = false;

    # Enable CUPS to print documents.
  services.printing = {
    enable = true;
  };

  # Avahi for printing
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

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