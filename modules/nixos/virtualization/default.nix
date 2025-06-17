{
  lib,
  config,
  pkgs,
  ...
}: let
  moduleName = "rofi";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
        };
      };
      waydroid.enable = true;

      docker.enable = true;

      users.users.shreyd.extraGroups = ["docker"];
    };
  };
}
