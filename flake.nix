{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    get-workspace-name.url = "path:get-workspace-name";
    kakoune-workspace.url = "path:kakoune-workspace";
    signal-desktop-compat.url = "path:signal-desktop-compat";
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , get-workspace-name
    , kakoune-workspace
    , signal-desktop-compat
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree {
          getworkspacename = get-workspace-name.defaultPackage.${system};
          kakoune-workspace = kakoune-workspace.defaultPackage.${system};
          signal-desktop = signal-desktop-compat.defaultPackage.${system};
        };
        # REMEMBER YOU MAY NEED TO NIX FLAKE UPDATE AS WELL FOR DEVSHELL
        devShell = pkgs.mkShell {
          buildInputs = builtins.attrValues packages;
        };
        overlays = final: prev: {
          inherit (packages) getworkspacename kakoune-workspace signal-desktop;
        };
      });
}
