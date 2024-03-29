# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    (builtins.fetchTarball {
      url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
      sha256 = "sha256:1mrc6a1qjixaqkv1zqphgnjjcz9jpsdfs1vq45l1pszs9lbiqfvd";
    })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shreyd = {
    isNormalUser = true;
    description = "Shrey Deogade";
    extraGroups = ["networkmanager" "wheel" "audio"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    unzip
    efibootmgr
    ffmpeg-full
    libsForQt5.qt5.qtgraphicaleffects
    comma

    # Dev
    git
    go
    python3
    rustup
    wireshark

    # Hyprland stuff
    swaybg
    swaynotificationcenter
    swww
    wofi
    wofi-emoji
    waybar
  ];

  # Shells
  environment.shells = with pkgs; [bash zsh fish];
  users.defaultUserShell = pkgs.bash;

  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
    fira-code-symbols
    font-awesome
  ];

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
