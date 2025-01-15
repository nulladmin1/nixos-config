{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nur.modules.homeManager.default
  ];
  home.packages = with pkgs;
    [
      anki
      blender
      chromium
      #ciscoPacketTracer8
      discord
      ghostwriter
      gimp
      inkscape
      kolourpaint
      krita
      libreoffice-qt6-still
      obs-studio
      obs-studio-plugins.wlrobs
      okular
      slack
      swww
      jetbrains-toolbox
    ]
    ++ (with pkgs.jetbrains; [
      idea-ultimate
      clion
      rust-rover
    ])
    ++ (with pkgs.kdePackages; [
      kdenlive
      qt6ct
    ])
    ++ (lib.lists.optional config.programs.yazi.enable ueberzugpp);
}
