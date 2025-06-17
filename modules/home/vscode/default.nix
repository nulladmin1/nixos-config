{
  lib,
  config,
  osConfig,
  system,
  inputs,
  ...
}: let
  moduleName = "vscode";
  sharedPackages = osConfig.environment.systemPackages ++ config.home.packages;
  inherit (lib.lists) optionals;

  # TODO
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    # VSCode
    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions;
        [
          adpyke.codesnap
          dbaeumer.vscode-eslint
          eamodio.gitlens
          esbenp.prettier-vscode
          jnoortheen.nix-ide
          kamadorueda.alejandra
          ms-python.python
          ms-python.vscode-pylance
          ms-vscode.live-server
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vsliveshare.vsliveshare
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          vscodevim.vim
          wakatime.vscode-wakatime
        ]
        ++ (optionals (builtins.elem pkgs.flutter sharedPackages) [
          dart-code.flutter
          dart-code.dart-code
        ])
        ++ (optionals (!config.catppuccin.enable) [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ]);
    };
  };
}
