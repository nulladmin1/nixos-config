{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nur.modules.homeManager.default
  ];
  home.packages = with pkgs;
    [
      anki
      #ciscoPacketTracer8
      discord
      ghostwriter
      gimp
      inkscape
      kolourpaint
      libreoffice-qt6-still
      obs-studio
      obs-studio-plugins.wlrobs
      okular
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
    ]);
}
