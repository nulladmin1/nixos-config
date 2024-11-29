{inputs, ...}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Lanzaboote for secure boot
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot/";
  };
}
