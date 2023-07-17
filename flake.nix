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
        pkgs = import nixpkgs { inherit system; };
        getPersonalPackages = pkgs: flake-utils.lib.flattenTree {
          get-workspace-name = get-workspace-name.defaultPackage.${system};
          kakoune-workspace = kakoune-workspace.defaultPackage.${system};
          signal-desktop = pkgs.signal-desktop;
        };
      in {
        packages = getPersonalPackages pkgs;
        overlays = final: prev:  getPersonalPackages prev;
      });
}
