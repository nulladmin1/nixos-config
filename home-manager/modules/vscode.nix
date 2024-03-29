{ config, pkgs, ... }:

{
  # VSCode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        adpyke.codesnap
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        kamadorueda.alejandra
        ms-python.python
        ms-python.vscode-pylance
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vsliveshare.vsliveshare
        rust-lang.rust-analyzer
        serayuzgur.crates
        tamasfe.even-better-toml
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
      ];
    # package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup ]);
  };
}