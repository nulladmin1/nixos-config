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
          calibre
          chromium
          #ciscoPacketTracer8
          discord
          errands
          papers
          pavucontrol
          #  jetbrains-toolbox
          simple-completion-language-server
          wl-clipboard
          wlsunset

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
          gimp3-with-plugins
          libreoffice-qt6-still
        ]
        ++ (with jetbrains; [
          idea-ultimate
          #   clion
          #   rust-rover
        ])
        ++ (with kdePackages; [
          kolourpaint
        ]));
    programs.obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    };
  };
}
