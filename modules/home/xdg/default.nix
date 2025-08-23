{
  lib,
  config,
  ...
}: let
  moduleName = "xdg";
in {
  options.custom.${moduleName} = {
    enable = lib.options.mkEnableOption moduleName;
  };

  config = lib.mkIf config.custom.${moduleName}.enable {
    xdg = {
      enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots/";
        };
      };

      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/xhtml+xml" = ["brave-browser.desktop"];
          "text/html" = ["brave-browse.desktop"];
          "text/xml" = ["brave-browser.desktop"];
          "x-scheme-handler/ftp" = ["brave-browser.desktop"];
          "x-scheme-handler/http" = ["brave-browser.desktop"];
          "x-scheme-handler/https" = ["brave-browser.desktop"];
          "application/pdf" = ["okular.desktop" "brave.desktop"];
          "application/zip" = ["nemo.desktop"];
          "image/*" = ["feh.desktop"];
          "text/*" = ["code.desktop"];
          "video/*" = ["vlc.desktop"];
        };
      };
    };
  };
}
