{ config, pkgs, ... }:

{
  services.xserver.sddm.theme = "${import ./sddm-theme.nix {inherit pkgs; }}";
}
