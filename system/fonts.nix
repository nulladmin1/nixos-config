{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerdfonts
    fira-code
    fira-code-symbols
    font-awesome
  ];
  fonts.fontDir.enable = true;
}
