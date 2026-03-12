# Project Conventions

## Task Management

Active work is tracked in `TASKS.md` at the project root using checkbox lists organized by phase or area.

Use task lists for multi-step work when:
- 3+ distinct steps are involved
- Non-trivial planning is required
- Multiple tasks are provided by the user

Mark tasks complete immediately after finishing. Keep exactly one task in-progress at a time.

## Project-Level Documentation

Standard files found at the root of most projects:

- **`CLAUDE.md`** — Entry point for agent context
- **`AGENTS.md`** — Project-specific graph entry points
- **`docs/conventions.md`** — Detailed coding standards
- **`docs/map/tree.md`** — Project structure overview

## Tracking System (`docs/track/`)

**Types:**
- `features/` — spec for a new capability
- `bugs/` — reproduction steps + expected behavior
- `plans/` — architecture decision for large, multi-part work
- `spikes/` — time-boxed research with a question and findings
- `implement/` — active working doc, generated from a feature, bug, or plan
- `archive/` — completed implement files

**Lifecycle:**
- Small work: write a spec in `features/` or `bugs/` → create an `implement/` file when work begins → move to `archive/` on completion
- Large work: write a `plans/` doc first → break it down into `features/` and `spikes/` → create `implement/` files as each piece begins → archive on completion
