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
        slack
        swww
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
        kdePackages.kdenlive
        kolourpaint
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
      ]));
}
