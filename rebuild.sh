#!/bin/bash
# set -e
pushd ~/Developer/nix-setup
# nvim oatman-pc.nix
# nvim flake.nix
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo darwin-rebuild --switch &>nixos-switch.log || (
 cat darwin-switch.log | grep --color error && false)
gen=$(sudo darwin-rebuild --list-generations | grep current)
git commit -am "$gen"
popd