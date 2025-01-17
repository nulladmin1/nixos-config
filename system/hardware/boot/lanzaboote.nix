{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Lanzaboote for secure boot
  boot.lanzaboote = lib.mkIf (config.var.bootloader == "lanzaboote") {
    enable = true;
    pkiBundle = "/etc/secureboot/";
  };
}
