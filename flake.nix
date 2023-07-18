{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    get_workspace_name.url = github:harris-chris/get-workspace-name;
    kakoune_workspace.url = github:harris-chris/kakoune-workspace;
  };
  outputs = {
    self
    , nixpkgs
    , get_workspace_name
    , kakoune_workspace
  }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        get_workspace_name.overlays.default
        kakoune_workspace.overlays.default
      ];
    };

    openfortivpn = (import (builtins.fetchGit {
      name = "my-old-revision";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";
    }) { inherit system; }).openfortivpn;

    getPersonalPackages = pkgs: {
      inherit openfortivpn;
      getworkspacename = pkgs.getworkspacename;
      kakoune-workspace = pkgs.kakoune-workspace;
      signal-desktop = pkgs.signal-desktop;
    };
  in {
    packages.${system} = getPersonalPackages pkgs;
    overlays.default = final: prev: getPersonalPackages final;
  };
}
