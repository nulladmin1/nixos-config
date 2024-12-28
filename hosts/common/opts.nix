{inputs, ...}: {
  imports = [../../shared/var-options.nix];

  config.var = rec {
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";
    username = "shreyd";

    git_username = "nulladmin1";

    flake = "/home/${username}/nixos-config/";

    editor = "nvim";

    wallpaper = "${inputs.wallpapers}/Arcane/arcane_powder_ekko_looking.png";
  };
}
