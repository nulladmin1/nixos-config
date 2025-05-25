{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  sharedPackages = osConfig.environment.systemPackages ++ config.home.packages;
  inherit (lib.lists) optionals;
in {
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
        # TODO
        #        vadimcn.vscode-lldb
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
    # package = pkgs.vscode.fhsWithPackages (ps: with ps; [rustup]);
  };
}
