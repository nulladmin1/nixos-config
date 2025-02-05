{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.var) username;
in {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
      };
    };
    waydroid.enable = true;

    # Docker
    docker.enable = true;
  };
  users.users.${username}.extraGroups = lib.lists.optional config.virtualisation.docker.enable "docker";
}
