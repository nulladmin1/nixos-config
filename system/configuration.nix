# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  username,
  name,
  ...
}: {
  imports = [
  ];
  # Enable NTFS and ExFAT Support
  boot.supportedFilesystems = ["ntfs" "exfat"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = name;
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "lp"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    unzip
    efibootmgr
    ffmpeg-full
    comma
    alacritty
    papirus-icon-theme
    vlc
    protonup
    sbctl

    # Dev
    git
    go
    python3
    rustup
    alejandra
    nil

    # Hyprland stuff
    # swaybg
    # swaynotificationcenter
    # swww
    # wofi
    # wofi-emoji
    # waybar
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
  };

  # Shells
  environment.shells = with pkgs; [bash zsh fish];
  users.defaultUserShell = pkgs.bash;

  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
    fira-code-symbols
    font-awesome
  ];
  fonts.fontDir.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
}
