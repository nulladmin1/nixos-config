{
  description = "Main system flake";

  inputs = {
    # Main Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Snowfall lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;
    };
}
