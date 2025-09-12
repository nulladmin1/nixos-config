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
          blueman
          calibre
          chromium
          #ciscoPacketTracer8
          discord
          foliate
          slack
          pavucontrol
          #  jetbrains-toolbox
          simple-completion-language-server

          inputs.wakatime-ls.packages.${pkgs.system}.default
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
          gimp3-with-plugins
          inkscape
          krita
          libreoffice-qt6-still
          obs-studio
          obs-studio-plugins.wlrobs
        ]
        # ++ (with jetbrains; [
        #   idea-ultimate
        #   clion
        #   rust-rover
        # ])
        ++ (with kdePackages; [
          kdenlive
          kolourpaint
        ]));
  };
}
