{
  pkgs,
  lib,
  ...
}: {
  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
