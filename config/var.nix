{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str path enum;
in {
  options.var = {
    name = mkOption {
      type = str;
      default = config.var.username;
      description = "Your Name";
    };

    email = mkOption {
      type = str;
      description = "Your Email";
    };

    username = mkOption {
      type = str;
      description = "Your Username";
    };

    sshKeyPath = mkOption {
      type = path;
      description = "Path to your SSH key (stored in the nixos-config repo, not in system)";
    };

    git_username = mkOption {
      type = str;
      default = config.var.username;
      description = "Your username for Git";
    };

    editor = mkOption {
      type = str;
      default = "vim";
      description = "Your preferred editor";
    };

    wallpaper = mkOption {
      type = str;
      description = "Your wallpaper";
    };

    bootloader = let
      inherit (lib.customLib) availableBootloaders;
    in
      mkOption {
        type = enum availableBootloaders;
        description = ''
          The bootloader to use. systemd-boot, grub and lanzaboote are the options. Lanzaboote is used for Secureboot
        '';
      };
  };
}
