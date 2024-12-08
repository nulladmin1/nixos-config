{pkgs, ...}: {
  fonts.packages = with pkgs;
    [
      fira-code
      fira-code-symbols
      font-awesome
    ]
    ++ (with pkgs.nerd-fonts; [
      jetbrains-mono
    ]);
  fonts.fontDir.enable = true;
}
