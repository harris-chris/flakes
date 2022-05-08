#! ${pkgs.bash}/bin/bash

desktop="$(${getworkspacename}/bin/getworkspacename)"
kakprofile=$(which kak)
kakoune=$(readlink -f "$kakprofile")
if [[ -z "$kakoune" ]]; then
  echo "Could not find kakoune installed"
  exit 1
fi

# bspc result was empty, so most likely not using bspwm
[ -z "$desktop" ] && exec $kakoune "$@"

$kakoune -clear

# if session with desktop id is found, connect to it. otherwise create it
if $kakoune -l | grep -q "^''${desktop}$"; then
    exec $kakoune -c "$desktop" "$@"
else
    exec $kakoune -s "$desktop" "$@"
fi
