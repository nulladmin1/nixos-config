{
  pkgs,
  hostname,
  ...
}: {
  # ZRAM Swap
  zramSwap.enable = true;

  # NTFS Support
  boot.supportedFilesystems = ["ntfs"];

  # Bootloader.
  #  boot.loader.systemd-boot = {
  #    enable = true;
  #    configurationLimit = 5;
  #  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot/";
  };

  #boot.loader = {
  #  efi = {
  #    canTouchEfiVariables = true;
  #  };
  #  grub = {
  #    enable = true;
  #    efiSupport = true;
  #    device = "nodev";
  #    useOSProber = true;
  #  };
  #};

  # Enable all firmware
  hardware.enableAllFirmware = true;

  networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable flatpak
  #services.flatpak.enable = true;

  # Enable XDG Portal (needed for flatpak)
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #  config.common.default = "gtk";
  #};
}
