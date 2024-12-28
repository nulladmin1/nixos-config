{pkgs, ...}: {
  services = {
    displayManager = {
      sddm = {
        # Enable SDDM
        enable = true;
        wayland.enable = true;

        package = pkgs.kdePackages.sddm;
      };
    };
  };
}
