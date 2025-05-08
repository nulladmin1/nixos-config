{
  pkgs,
  config,
  ...
}: let
  inherit (config.var) username;
in {
  environment.systemPackages = with pkgs.kdePackages; [
    kwallet
    kwalletmanager
  ];

  security.pam.services.${username}.kwallet = {
    inherit (config.services.desktopManager.plasma6) enable;

    package = pkgs.kdePackages.kwallet-pam;
  };
}
