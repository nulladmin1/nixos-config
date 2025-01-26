{
  pkgs,
  pkgs-stable,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nur.modules.homeManager.default
  ];
  home.packages =
    (with pkgs;
      [
        anki
        chromium
        #ciscoPacketTracer8
        discord
        ghostwriter
        kdePackages.qt6ct
        okular
        slack
        swww
        jetbrains-toolbox
      ]
      ++ (lib.lists.optional config.programs.yazi.enable ueberzugpp))
    ++ (with pkgs-stable;
      [
        blender
        gimp
        inkscape
        kdePackages.kdenlive
        kolourpaint
        krita
        libreoffice-qt6-still
        obs-studio
        obs-studio-plugins.wlrobs
      ]
      ++ (with jetbrains; [
        idea-ultimate
        clion
        rust-rover
      ]));
}
