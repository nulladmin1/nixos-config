{
  config,
  pkgs,
  ...
}: let
  inherit (config.var) username;
  inherit (config.var) name;
in {
  users.users.${username} = {
    isNormalUser = true;
    description = name;
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "lp"];
  };

  environment.shells = with pkgs; [bash zsh fish];
  users.defaultUserShell = pkgs.bash;
}
