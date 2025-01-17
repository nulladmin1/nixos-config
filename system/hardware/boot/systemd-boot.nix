{
  config,
  lib,
  ...
}: {
  # Systemd-boot Bootloader
  boot.loader.systemd-boot = lib.mkIf (config.var.bootloader == "systemd-boot") {
    enable = true;
    configurationLimit = 5;
  };
}
