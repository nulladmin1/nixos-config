{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  moduleName = "niri";
in {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite-unstable
      libsecret
    ];

    # Use Soteria polkit instead of KDE Polkit
    systemd.user.services.niri-flake-polkit.serviceConfig.ExecStart = lib.mkForce "${pkgs.soteria}/bin/soteria";
  };
}
