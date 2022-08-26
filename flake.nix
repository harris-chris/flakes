{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    get-workspace-name.url = github:harris-chris/get-workspace-name;
    kakoune-workspace.url = github:harris-chris/kakoune-workspace;
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , get-workspace-name
    , kakoune-workspace
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree {
          get-workspace-name = get-workspace-name.defaultPackage.${system};
          kakoune-workspace = kakoune-workspace.defaultPackage.${system};
          signal-desktop = pkgs.signal-desktop;
        };
        # REMEMBER YOU MAY NEED TO NIX FLAKE UPDATE AS WELL FOR DEVSHELL
        devShell = pkgs.mkShell {
          buildInputs = builtins.attrValues packages;
        };
        overlays = final: prev: {
          inherit (packages) get-workspace-name kakoune-workspace signal-desktop;
        };
      });
}
