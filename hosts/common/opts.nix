{
  lib,
  inputs,
  ...
}: {
  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

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
