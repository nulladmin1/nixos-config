{
  lib,
  config,
  ...
}: let
  moduleName = "locales";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = let
    locale = "en_US.UTF-8";
  in
    lib.mkIf config.custom.${moduleName}.enable {
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
      location = {
        # Enable location manually
        provider = "manual";

        # Manually set latitude and longtitude (not my actual lat/long)
        latitude = 40.0;
        longitude = -77.0;
      };

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    };
}
