lib: {
  # ------------ COMMON UTILITY FUNCTIONS --------------------- #
  capitalize = let
    inherit (lib.strings) toUpper substring;
  in
    str: toUpper (substring 0 1 str) + substring 1 (builtins.stringLength str) str;

  prefer = pairs: let
    result = builtins.filter (pair: pair.condition) pairs;
  in
    if result == []
    then null
    else (builtins.head result).value;

  # ------------- TYPES AND STUFF ----------------------------#
  availableBootloaders = [
    "systemd-boot"
    "lanzaboote"
    "grub"
  ];
}
