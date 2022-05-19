{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    signal-desktop.url = path:./signal-desktop-compat;
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , signal-desktop
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages.signal-desktop = signal-desktop.defaultPackage.${system};
      });
}
