# Nix Configuration

This repository contains Nix configurations for my computers using a modular flake-based architecture.

## Usage

### Building and Switching

```bash
# Using the rebuild script (auto-commits changes)
./rebuild.sh

# Using make commands
make rebuild-nixos    # For NixOS systems
make rebuild-macos    # For Darwin systems
make update           # Update flake inputs
make gc               # Garbage collection
```

### Common Customization

**System packages:** `modules/desktop/packages.nix`

**GNOME settings:** `modules/desktop/environment/gnome.nix`

**User configuration:** `modules/users/henry/default.nix`

**Host-specific:** `modules/hosts/gawain/default.nix`

## Architecture

- **Nix Flakes** for reproducible builds
- **flake-parts** for modular flake composition
- **import-tree** for automatic module discovery
- **Home Manager** for user configurations

## Project Structure

```
nix-setup/
├── flake.nix              # Main flake configuration
├── modules/               # Modular configuration system
│   ├── base/              # Core system configurations
│   ├── desktop/           # Desktop environment configs
│   ├── dev/               # Development tools
│   ├── flake/             # Flake infrastructure
│   ├── games/             # Gaming configurations
│   ├── hosts/             # Host-specific modules
│   ├── sound/             # Audio configuration
│   └── users/             # User configurations
├── config/                # Application configurations
│   ├── hypr/              # Hyprland configs
│   ├── waybar/            # Waybar status bar
│   └── wallpaper/         # Wallpaper images
├── ags/                   # Desktop Widgets
└── to_migrate/            # Legacy configs to migrate
```

## Active Hosts

### Gawain (`modules/hosts/gawain/`)
**Desktop Gaming PC (x86_64-linux)**
- NixOS with GNOME desktop environment
- NVIDIA graphics drivers
- Gaming-specific configurations

## Pending Migration

The `to_migrate/` directory contains legacy configurations for:
- **Albion** - Work MacBook Pro (aarch64-darwin)
- **Mordred** - Personal MacBook Pro (aarch64-darwin)