# Nix Setup Agent Guide

All docs must be canonical, no past commentary, only live state.

## Project Summary

Personal Nix flake for NixOS and macOS (nix-darwin), with Home Manager modules and reusable profiles.

## Repository Structure

### Flake and Inputs

- `flake.nix` — main flake outputs, system list, overlays, modules, and machines
- `flake.lock` — pinned inputs

### Hosts

- `hosts/siegfried/default.nix` — host configuration
- `hosts/siegfried/hardware-configuration.nix` — hardware config

### Modules

- `modules/nixos/` — system-level NixOS modules and `hokum.*` options
- `modules/home/` — Home Manager modules
- `modules/users/` — user-specific modules

### Profiles and Packages

- `profiles/` — composable profiles (desktop/dev/gaming/etc)
- `profiles/gnome/` and `profiles/homelab/` — profile subgroups
- `overlays/` — nixpkgs overlays

### Home Config

- `home/` — per-user Home Manager config roots

## Common Commands

- `make nixos` — rebuild and switch the config for the current hostname
- `make nixos-oma` — rebuild with local omarchy flake override
- `make macos` — rebuild nix-darwin config
- `make update` — update flake inputs
- `make fmt` — format Nix files
- `make gc` — garbage collection
