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
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };
}
