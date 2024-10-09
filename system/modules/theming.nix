{ pkgs, lib, wallpaper, ... }:
{
  services.displayManager.sddm.catppuccin = {
    background = let
      catppuccin_wallpapers = pkgs.fetchFromGitHub {
        owner = "Gingeh";
        repo = "wallpapers";
        rev = "2530dba028589bda0ef6743d7960bd8a5b016679";
        hash = "sha256-FiilS+t6QszTsnaIFVRRC8pQ6oTcv6qvKMf9cD5AoBQ=";
      };
    in "${catppuccin_wallpapers}/misc/virus.png";
    font = "JetBrainsMono Nerd Font";
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";    
  };
}
