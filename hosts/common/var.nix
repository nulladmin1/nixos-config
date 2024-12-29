{
  lib,
  config,
  ...
}: {
  options.var = {
    name = lib.mkOption {
      type = lib.types.str;
      default = config.var.username;
      description = "Your Name";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Your Email";
    };

    username = lib.mkOption {
      type = lib.types.str;
      description = "Your Username";
    };

    git_username = lib.mkOption {
      type = lib.types.str;
      default = config.var.username;
      description = "Your username for Git";
    };

    editor = lib.mkOption {
      type = lib.types.str;
      default = "vim";
      description = "Your preferred editor";
    };

    wallpaper = lib.mkOption {
      type = lib.types.str;
      description = "Your wallpaper";
    };

    flake = let
      flakePath = builtins.toString ../../.;
    in
      lib.mkOption {
        type = lib.types.str;
        default = flakePath;
        description = "Path to the nixos-config flake. Default is: ${flakePath}";
      };
  };
}
