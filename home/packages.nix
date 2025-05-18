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
