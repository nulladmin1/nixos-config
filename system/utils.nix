{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.nixosModules.nix-index
  ];
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
}
