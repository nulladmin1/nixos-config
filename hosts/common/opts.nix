{
  lib,
  inputs,
  ...
}: {
  options.var = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.var = let
    username = "shreyd";
  in {
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";
    inherit username;

    git_username = "nulladmin1";

    flake = "/home/${username}/nixos-config/";

    editor = "nvim";

    wallpaper = "${inputs.wallpapers}/Arcane/arcane_powder_ekko_looking.png";

    prefer = pairs: let
      result = builtins.filter (pair: pair.condition) pairs;
    in
      if result == []
      then null
      else (builtins.head result).value;
  };
}
