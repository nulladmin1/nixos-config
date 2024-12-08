{
  pkgs,
  lib,
  config,
  ...
}: {
  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  #   programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  environment.systemPackages = with pkgs;
    [
      (catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["mauve"];
      })
    ]
    ++ (with config.nur.repos; [
      shadowrz.klassy-qt6
    ]);
}
