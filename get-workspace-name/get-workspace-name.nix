{ stdenv, bash, coreutils, gcc, wmctrl }:

stdenv.mkDerivation rec {
  name = "getworkspacename";
  src = ./getWorkspaceName.cpp;
  dontUnpack = true;
  buildPhase = ''
    g++ -o getworkspacename $src
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp getworkspacename $out/bin
    ln -s ${wmctrl.out}/bin/wmctrl $out/bin/wmctrl
    chmod +x $out/bin/getworkspacename
  '';
  inherit gcc coreutils;
  system = builtins.system;
}
