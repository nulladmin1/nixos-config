{...}: {
  # Systemd-boot Bootloader
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
}
