# AGENTS.md

This repository owns generic Lenso terminal command composition. Keep product
and Agent behavior outside it.

## Architecture

- Preserve `lenso.terminal.command-provider@1` and
  `lenso.terminal.command@1` as distinct roles.
- Feature Plugins own commands and final domain authorization.
- `lenso.terminal.command` owns deterministic catalog validation and routing.
- CLI surfaces own parsing and process I/O; Kernel owns no Clap, argv, or TTY
  behavior.
- Do not add Agent Session, model, Tool, TUI transcript, or Host policy here.
- Do not enable cross-lane transfer without real multi-Adapter stream proof.

## Changes

- Use Conventional Commits with concise English subjects.
- Preserve generated artifacts and run the contract freshness gate.
- Run Rust commands through
  `/Users/leosouthey/Projects/framework/.lenso-tools/bin/lenso-cargo` when
  available.
- Use `wt switch --create` for isolated work after the initial repository is
  published.

## Validation

```sh
cargo fmt --all -- --check
./scripts/check-contracts.sh
cargo check --locked --workspace --all-targets
cargo test --locked --workspace --all-targets
cargo clippy --locked --workspace --all-targets -- -D warnings
./scripts/check-package-readiness.sh
```
