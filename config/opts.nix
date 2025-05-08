{inputs, ...}: {
  imports = [
    ./var.nix
  ];

  config.var = {
    username = "shreyd";
    name = "Shrey Deogade";
    email = "shrey.deogade@protonmail.com";

    git_username = "nulladmin1";

    editor = "nvim";

    sshKeyPath = ../hosts/common/keys/id_ed25519.pub;

    wallpaper = "${inputs.wallpapers}/Arcane/arcane_powder_ekko_looking.png";

    desktopEnvironments = [
      "hyprland"
      "gnome"
    ];
  };
}
