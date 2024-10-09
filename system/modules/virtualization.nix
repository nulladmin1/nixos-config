{
  config,
  pkgs,
  username,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
  virtualisation.waydroid.enable = true;

  # Docker
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = ["docker"];
}
