# Nix Configuration

This repository contains Nix configurations for my three different computers that I work with on a daily basis.

## Hosts

### Albion (`hosts/albion/`)
**Work MacBook Pro (ARM64)**
- **Platform**: `aarch64-darwin` (Apple Silicon)
- **Primary User**: `henry`
- **Purpose**: Work development machine
- **Key Features**:
  - macOS Darwin configuration with desktop environment
  - Homebrew integration for work-specific tools

### Gawain (`hosts/gawain/`)
**Desktop Gaming PC (x86_64)**
- **Platform**: `x86_64-linux` (Intel-based)
- **Primary User**: `henry`
- **Purpose**: Desktop gaming and high-performance computing
- **Key Features**:
  - NixOS with KDE Plasma desktop environment
  - NVIDIA graphics drivers with hardware acceleration

### Mordred (`hosts/mordred/`)
**Personal MacBook Pro (ARM64)**
- **Platform**: `aarch64-darwin` (Apple Silicon)
- **Primary User**: `henrysipp`
- **Purpose**: Personal development and daily use
- **Key Features**:
  - macOS Darwin configuration with desktop environment
  - Clean personal setup 

## Architecture

Each host imports shared modules from the `modules/` directory:
- **Darwin hosts** use `darwinModules.darwin-desktop`
- **NixOS hosts** use `nixosModules.desktop` and desktop environment modules
- Home Manager configurations are tailored per platform (`darwin-desktop` vs `desktop`)

## Usage

Use the `rebuild.sh` script or `Makefile` to build and switch configurations for each host.
