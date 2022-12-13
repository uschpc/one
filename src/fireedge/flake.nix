{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      package = "one";
      pkgs = import nixpkgs { inherit system; };
    in {
      defaultPackage = self.packages."${package}:exe:${package}";
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodejs
          zeromq
        ];
        NODE_OPTIONS = "--openssl-legacy-provider";
      };
    });
}
