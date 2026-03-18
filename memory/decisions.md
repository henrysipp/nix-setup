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
## 2026-03-17 00:00
Context: Platform targeting
Type: preference
Rule: Prefer Linux-only packaging in this repo unless macOS support is explicitly needed.
Why: Repo is focused on NixOS; extra platforms add noise.
