{ config, pkgs, locale, ... }:

{
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Set RTC to local
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };

  # Enable location manually
  location.provider = "manual";

  # Manually set latitude and longtitude (not my actual lat/long)
  location.latitude = 40.0;
  location.longitude = -77.0;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
 
}