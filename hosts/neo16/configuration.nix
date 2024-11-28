# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (config.var) username;
in {
  imports = [
    ./opts.nix
    ./disko.nix
    ./hardware-configuration.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  home-manager.users.${username} = import ./home.nix;

  # KWallet login every reboot
  security.pam.services.${username}.kwallet.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim

    # My custom Nixvim configuration
    inputs.nixvim.packages.${pkgs.system}.default

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
