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

### Import Hierarchy (Gawain Example)

```
flake.nix
└── gawain system configuration
    └── hosts/gawain/configuration.nix
        ├── hardware-configuration.nix
        ├── nixosModules.desktop-common
        ├── nixosModules.gnome
        └── home-manager.users.henry
            └── homeModules.gnome
```

Key module directories:
- `modules/core/` - Base system packages, fonts, network, services
- `modules/nixos/` - NixOS-specific desktop environments (GNOME, KDE, Hyprland)
- `modules/home/` - Home Manager configurations for each desktop environment

### Common Customization Examples

**To add system-wide packages:**
- Edit `modules/core/packages.nix` for packages available on all hosts
- Edit `modules/nixos/desktop-common.nix` for Linux desktop-specific packages
- Edit `modules/darwin/darwin-desktop.nix` for macOS-specific packages

**To customize GNOME settings:**
- Edit `modules/nixos/gnome.nix` for system-level GNOME configuration
- Edit `modules/home/gnome.nix` for user-specific GNOME settings (extensions, themes)

**To add user-specific programs:**
- Edit `modules/home/home-shared.nix` for programs on all platforms
- Edit specific home modules like `modules/home/nix-desktop/default.nix` for Linux-only programs

**To change host-specific settings:**
- Edit `hosts/gawain/configuration.nix` for Gawain-only system settings
- Edit `hosts/gawain/variables.nix` for host-specific variables
- Edit `hosts/gawain/users/henry/home-configuration.nix` for user overrides on that host

## Usage

Use the `rebuild.sh` script or `Makefile` to build and switch configurations for each host.
