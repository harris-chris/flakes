{ pkgs ? import <nixpkgs> {} }:

with pkgs; {
  getworkspacename = callPackage ./get-workspace-name.nix {};
}
