{pkgs, ...}: {
  programs.command-not-found.enable = false;

  programs.nix-index-database.comma.enable = true;

  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  # ADB
  programs.adb.enable = true;
}
