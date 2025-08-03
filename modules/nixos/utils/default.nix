{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  moduleName = "utils";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];

  config = lib.mkIf config.custom.${moduleName}.enable {
    programs.command-not-found.enable = false;

    programs.nix-index-database.comma.enable = true;

    programs.bash.interactiveShellInit = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';

    # SSH
    programs.ssh = {
      enableAskPassword = false;
    };

    # ADB
    programs.adb.enable = true;

    # LocalSend
    programs.localsend.enable = true;
  };
}
