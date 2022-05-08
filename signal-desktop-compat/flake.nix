{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=c82b46413401efa740a0b994f52e9903a4f6dcd5";
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        signal = pkgs.signal-desktop;
      in {
        defaultPackage = signal;
        devShell = pkgs.mkShell { buildInputs = [ signal ]; };
      });
}

