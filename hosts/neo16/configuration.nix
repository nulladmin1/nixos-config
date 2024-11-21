# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  username = config.var.username;
  name = config.var.name;
in {
  imports = [
    ./opts.nix
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = name;
    extraGroups = ["networkmanager" "wheel" "audio" "adbusers" "lp"];
  };

  # KWallet login every reboot
  security.pam.services.${username}.kwallet.enable = true;

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
  ];

  environment.sessionVariables = {
    #    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
  };

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
  fonts.fontDir.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
}
