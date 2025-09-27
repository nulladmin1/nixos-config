{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "users";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    users.users.shreyd = {
      isNormalUser = true;
      description = "Shrey Deogade";
      extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "lp" "wireshark" "fuse"];
      openssh.authorizedKeys.keys = [
        (builtins.readFile ../../../secrets/id_ed25519.pub)
      ];
      shell = pkgs.bash;
    };

    users.defaultUserShell = pkgs.bash;

    services.logind.settings.Login.killUserProcesses = false;
  };
}
