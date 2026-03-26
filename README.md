# Nix Configuration

My personal nix configuration. 

## Quick Start

```bash
# Rebuild and switch to new configuration
make nixos

# Override the selected host explicitly if needed
make nixos HOST=siegfried

# Rebuild, but with override path to local omarchy  flake
make nixos-oma

# Update flake inputs
make update
```
