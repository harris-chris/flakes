{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    personal-pkgs.url = "path:../";
    # personal-pkgs.url = github:harris-chris/flakes;
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , personal-pkgs
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        devShell = pkgs.mkShell {
          # buildInputs = pkgs.builtins.attrValues personal-pkgs.packages.${system};
          # buildInputs = [ personal-pkgs.packages.${system}.getworkspacename ];
        };
      });
}
