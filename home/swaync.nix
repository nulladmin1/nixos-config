{config, ...}: let
  inherit (config.catppuccin) flavor;
  inherit (config.wayland.windowManager.hyprland) enable;
in {
  services.swaync = {
    inherit enable;
    style = let
      theme = builtins.fetchurl {
        url = "https://github.com/catppuccin/swaync/releases/download/v0.2.3/${flavor}.css";
        sha256 = "1xr1wkg4zb467b35xhsfqiwhimfnn88i3ml5rf173rkm7fyby9qy";
      };
    in
      builtins.readFile "${theme}";
  };
}
