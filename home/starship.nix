{
  config,
  pkgs,
  ...
}: {
  # Starship
  programs.starship = {
    enable = true;
    settings = {
      # Other config here
      #        format = "$all"; # Remove this line to disable the default prompt format
    };
  };
}
