{ config, pkgs, ... }:

{
  # Enable picom
  services.picom = {
    enable = true;
    fade = true;
    fadeSteps = [
      0.1
      0.1
    ];
    opacityRules = [
      "80:class_g = 'Alacritty' && focused"
      "70:class_g = 'Alacritty' && !focused"
    ];
    inactiveOpacity = 0.9;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 8;
      };

    };
    shadow = true;
    shadowExclude = [
      "name = Notification"
    ];
  };
}
