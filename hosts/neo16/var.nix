{
  lib,
  inputs,
  system,
  ...
}: {
  config.var = let
    username = "shreyd";
  in {
    hostname = "shrey-neo16-nixos";
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";
    inherit username;

    git_username = "nulladmin1";
    git_email = "shrey.deogade@protonmail.com";

    flake = "/home/${username}/nixos-config/";

    locale = "en_US.UTF-8";

    editor = "lvim";

    wallpaper = "${inputs.wallpapers.packages.${system}.default}/random.png";
    font = "JetBrainsMono Nerd Font";
    theme = {
      name = "catppuccin";
      scheme = "mocha";
      accent = "mauve";
    };
  };
}
