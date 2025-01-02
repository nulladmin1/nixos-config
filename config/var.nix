{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption;
  inherit (lib.types) str enum;
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
        type = enum (lib.attrNames availableBootloaders);
        default = "systemd-boot";
        description = ''
          The bootloader to use. systemd-boot is the default, and grub and lanzaboote are the other options. Lanzaboote is used for Secureboot
        '';
      };
  };
}
