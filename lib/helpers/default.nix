{lib, ...}: {
  importModules = ms:
    lib.genAttrs ms (m: {
      enable = true;
    });
}
