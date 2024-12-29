{inputs, ...}: {
  imports = [
    ./var.nix
  ];

  config.var = let
    username = "shreyd";
  in {
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";
    inherit username;

    git_username = "nulladmin1";

    editor = "nvim";

    wallpaper = "${inputs.wallpapers}/Arcane/arcane_powder_ekko_looking.png";
  };
}
