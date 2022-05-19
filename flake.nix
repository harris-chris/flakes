{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    signal-desktop.url = path:./signal-desktop-compat;
    get-workspace-name.url = path:./get-workspace-name;
    kakoune-workspace.url = path:./kakoune-workspace;
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , signal-desktop
    , get-workspace-name
    , kakoune-workspace
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages.signal-desktop = signal-desktop.defaultPackage.${system};
        packages.get-workspace-name = get-workspace-name.defaultPackage.${system};
        packages.kakoune-workspace = kakoune-workspace.defaultPackage.${system};
      });
}
