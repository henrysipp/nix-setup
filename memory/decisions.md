# Decisions

## Canonical Memory Model

- `memory/decisions.md` stores active, high-signal canonical rules only.
- Full historical detail for the pre-compaction log is archived at `memory/archive/decisions-YYYY-MM-DD-full.md`.
- New low-signal implementation-step history should go to `memory/archive/` instead of this file.

## Entry Template

```md
## YYYY-MM-DD HH:mm
Context: <task or feature>
Type: decision | preference
Rule: <one-line future behavior>
Why: <short reason this rule exists>
```

## Active Canonical Rules
## 2026-03-17 20:43
Context: command execution preference
Type: preference
Rule: Run non-sudo commands directly instead of asking the user to run them.
Why: User requested the agent execute non-sudo commands itself.
## 2026-03-17 00:00
Context: Platform targeting
Type: preference
Rule: Prefer Linux-only packaging in this repo unless macOS support is explicitly needed.
Why: Repo is focused on NixOS; extra platforms add noise.
## 2026-03-17 20:55
Context: Repository architecture
Type: preference
Rule: Optimize the repo for being solid, well-configured, and easily configurable across multiple hosts.
Why: User wants a durable multi-host Nix architecture rather than a single-machine setup.
## 2026-03-17 20:56
Context: Module option namespace
Type: preference
Rule: Use the `hokum.*` namespace for custom NixOS/Home Manager options in this repo.
Why: User explicitly requested `hokum` as the project option prefix.
## 2026-03-17 20:58
Context: User configuration architecture
Type: preference
Rule: Retain Home Manager as the user configuration layer; do not replace it with custom activation-script-based management.
Why: User explicitly does not want Home Manager replaced.
## 2026-03-17 21:05
Context: Multi-host refactor
Type: decision
Rule: Structure the repo around `lib/host.nix`, `hosts/`, and `modules/nixos/` with `hokum.*` options, while keeping Home Manager as the user layer.
Why: This is the chosen phase-one architecture for scaling the repo to multiple hosts cleanly.
## 2026-03-18 17:24
Context: System module assembly
Type: decision
Rule: Import Berkeley Mono directly from `modules/nixos/default.nix` and keep it separate from the Omarchy module.
Why: The font should be available system-wide without pulling Hyprland-oriented Omarchy configuration into the active host.
## 2026-03-25 00:00
Context: Desktop app configuration placement
Type: decision
Rule: Re-enable and maintain active desktop applications in `modules/nixos/*`; treat `profiles/*` as transitional unless a host still imports them directly.
Why: The live host graph uses `modules/nixos/*`, and editing legacy `profiles/*` alone would not affect the active system.
