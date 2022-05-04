{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    get-workspace-name.url = "path:get-workspace-name";
    kakoune-workspace.url = "path:kakoune-workspace";
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
          getworkspacename = get-workspace-name.defaultPackage.${system};
          kakoune-workspace = kakoune-workspace.defaultPackage.${system};
        };
        devShell = pkgs.mkShell {
          buildInputs = builtins.attrValues packages;
        };
      });
}
