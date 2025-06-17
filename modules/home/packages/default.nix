{
  lib,
  config,
  inputs,
  system,
  pkgs,
  ...
}: let
  moduleName = "apps";

  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    home.packages =
      (with pkgs;
        [
          anki
          bambu-studio
          calibre
          chromium
          #ciscoPacketTracer8
          discord
          slack
          jetbrains-toolbox
        ]
        ++ (with kdePackages; [
          ghostwriter
          qt6ct
          okular
        ])
        ++ (lib.lists.optional config.programs.yazi.enable ueberzugpp))
      ++ (with pkgs-stable;
        [
          blender
          gimp
          inkscape
          krita
          libreoffice-qt6-still
          obs-studio
          obs-studio-plugins.wlrobs
          varia
        ]
        ++ (with jetbrains; [
          idea-ultimate
          clion
          rust-rover
        ])
        ++ (with kdePackages; [
          kdenlive
          kolourpaint
        ]));
  };
}
