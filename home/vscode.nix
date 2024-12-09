{
  config,
  pkgs,
  ...
}: {
  # VSCode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
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
    ];
    # package = pkgs.vscode.fhsWithPackages (ps: with ps; [rustup]);
  };
}
