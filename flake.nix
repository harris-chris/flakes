{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
  };
  outputs = {
    self
    , nixpkgs
  }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
    };

    openfortivpn = (import (builtins.fetchGit {
      name = "my-old-revision";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
    }) { inherit system; }).openfortivpn;

    getPersonalPackages = _: {
      inherit openfortivpn;
      signal-desktop = pkgs.signal-desktop;
    };
  in {
    packages.${system} = getPersonalPackages pkgs;
    overlays.default = final: prev: getPersonalPackages final;
  };
}
