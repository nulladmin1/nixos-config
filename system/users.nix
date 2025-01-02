{
  config,
  pkgs,
  ...
}: let
  inherit (config.var) username name sshKeyPath;
in {
  #  sops.secrets.shreyd-password.neededForUsers = true;
  #  users.mutableUsers = false;

  users.users.${username} = {
    isNormalUser = true;
    description = name;
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "lp"];
    #    hashedPasswordFile = config.sops.secrets.shreyd-password.path;

    openssh.authorizedKeys.keys = [
      (builtins.readFile sshKeyPath)
    ];
  };

  environment.shells = with pkgs; [bash zsh fish];
  users.defaultUserShell = pkgs.bash;
}
