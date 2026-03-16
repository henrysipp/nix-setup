# Nix Setup Agent Guide

All docs must be canonical, no past commentary, only live state.

## Agent Memory (Project Scratchpad)

Purpose: keep lightweight, durable project memory so agents avoid repeating mistakes and follow user/project preferences over time.

### Memory Location (Repo Root)

Store memory in the project root under `./memory/`:

- `memory/decisions.md` — active canonical rules only (high-signal, current behavior)
- `memory/mistakes.md` — mistakes, fixes, and prevention rules
- `memory/todo.md` — open loops and follow-up tasks
- `memory/context.md` — optional short-lived working context (can be compacted)
- `memory/archive/` — detailed historical decision logs moved out of canonical memory during compaction

### Automatic Write Rules

Agents should write memory entries when ANY of the following happens:

1. User states a stable preference or rule ("do it this way").
2. Agent makes a non-trivial mistake and corrects it.
3. A decision is made that affects future implementation.
4. A follow-up task is identified but not completed immediately.

Write target:
- Put durable behavior/rules in `memory/decisions.md`.
- Put implementation-step history and low-signal details in `memory/archive/*`.
- Keep `memory/mistakes.md` and `memory/todo.md` append-only.

Do NOT write:
- trivial chatter
- transient debug noise
- secrets/tokens/passwords
- private data not required for project execution

### Required Read Rules (Before Work)

Before starting a task, agents must read:

1. `memory/decisions.md`
2. recent entries in `memory/mistakes.md`
3. open items in `memory/todo.md`
4. `memory/archive/*` only when current files do not provide enough context

Then apply those constraints during planning and implementation.

### Entry Format (Canonical Decisions)

Use this compact format:

```md
## YYYY-MM-DD HH:mm
Context: <task or feature>
Type: decision | preference
Rule: <one-line future behavior>
Why: <short reason this rule exists>
```

### Mistake Entry Requirements

For entries in `memory/mistakes.md`, include:

- `Root cause:`
- `Fix applied:`
- `Prevention rule:`

### Maintenance

- Keep `memory/decisions.md` compact and high-signal (target: <= 150 lines).
- Compaction should move detailed historical entries to `memory/archive/` and keep `memory/decisions.md` as canonical rules.
- During compaction, preserve meaning and keep at least the latest 30 days of detail in `memory/archive/`.
- When compacting `memory/decisions.md`, append one compaction entry noting where full history was archived.

## Project Summary

Personal Nix flake for NixOS and macOS (nix-darwin), with Home Manager modules and reusable profiles.

## Repository Structure

### Flake and Inputs

- `flake.nix` — main flake outputs, system list, overlays, modules, and machines
- `flake.lock` — pinned inputs

### Machines

- `machines/siegfried/default.nix` — host configuration
- `machines/siegfried/hardware-configuration.nix` — hardware config

### Modules

- `modules/system/` — system-level NixOS modules
- `modules/home/` — Home Manager modules
- `modules/users/` — user-specific modules

### Profiles and Packages

- `profiles/` — composable profiles (desktop/dev/gaming/etc)
- `profiles/gnome/` and `profiles/homelab/` — profile subgroups
- `overlays/` — nixpkgs overlays

### Home Config

- `home/` — per-user Home Manager config roots

## Common Commands

- `make nixos` — rebuild and switch NixOS config
- `make nixos-oma` — rebuild with local omarchy flake override
- `make macos` — rebuild nix-darwin config
- `make update` — update flake inputs
- `make fmt` — format Nix files
- `make gc` — garbage collection
