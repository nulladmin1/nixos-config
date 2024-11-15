{
  pkgs,
  lib,
  hyprland,
  system,
  ...
}: {
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprland.packages.${system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # WayFire
  #programs.wayfire = {
  #  enable = true;
  #  plugins = with pkgs.wayfirePlugins; [
  #    wcm
  #    wf-shell
  #    wayfire-plugins-extra
  #  ];
  #};

  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  # Gnome
  #services.xserver.desktopManager.gnome.enable = true;

  # Enable SDDM
  services = {
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
