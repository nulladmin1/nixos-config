{
  config,
  pkgs,
  ...
}: let
  inherit (config.var) username;
  inherit (config.var) name;
in {
  sops.secrets.shreyd-password.neededForUsers = true;
  users.mutableUsers = false;

  users.users.${username} = {
    isNormalUser = true;
    description = name;
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "lp"];
    hashedPasswordFile = config.sops.secrets.shreyd-password.path;

    openssh.authorizedKeys.keys = [
      (builtins.readFile ../shared/keys/id_ed25519.pub)
    ];
  };

  environment.shells = with pkgs; [bash zsh fish];
  users.defaultUserShell = pkgs.bash;
}
