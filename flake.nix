{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    get-workspace-name.url = "path:get-workspace-name";
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , get-workspace-name
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree {
          getworkspacename = get-workspace-name.defaultPackage.${system};
        };
      });
}
