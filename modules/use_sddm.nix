{ config, pkgs, ... }:

{
  services.xserver.displayManager.sddm.theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
}
