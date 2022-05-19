{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    personal-pkgs.url = "github:harris-chris/flakes";
    # personal-pkgs.url = "path:../";
  };
  outputs = {
    self
    , nixpkgs
    , flake-utils
    , personal-pkgs
  }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        personal-overlay = personal-pkgs.overlays.${system};
        overlays = [ personal-overlay ];
        pkgs = import nixpkgs { inherit system overlays; };
      in rec {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.kakoune-workspace ];
          # buildInputs = builtins.attrValues personal-pkgs.packages.${system};
        };
      });
}
