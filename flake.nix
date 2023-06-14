{
  description = "Astarte command line client utility";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = github:numtide/flake-utils;
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.${system}.default ];
        };
      in
      {
        overlays.default = final: prev: {
          astartectl = final.callPackage .nix/package.nix { };
        };
        overlay = self.overlays.default;
        packages = { inherit (pkgs) astartectl; };
        packages.default = self.packages.${system}.astartectl;
        devShells.default = pkgs.callPackage .nix/shell.nix { };
      }
    );
}
