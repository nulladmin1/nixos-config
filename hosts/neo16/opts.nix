{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [../../shared/var-options.nix];

  config.var = {
    hostname = "shrey-neo16-nixos";
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";
    username = "shreyd";

    git_username = "nulladmin1";
    git_email = "shrey.deogade@protonmail.com";

    flake = "/home/shreyd/nixos-config/";

    locale = "en_US.UTF-8";

    editor = "nvim";

    wallpaper = "${inputs.wallpapers.packages.${pkgs.system}.default}/random.png";
    font = "JetBrainsMono Nerd Font";
    theme = {
      name = "catppuccin";
      scheme = "mocha";
      accent = "mauve";
    };
  };
}
