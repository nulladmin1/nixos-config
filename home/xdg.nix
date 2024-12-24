{config, ...}: {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots/";
      };
    };
  };
}
