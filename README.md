# lenso-terminal

Portable terminal command contracts, the validated command aggregate Plugin,
and the process-owned CLI parser used by Lenso products.

## Ownership

This repository owns the generic command composition path:

- `lenso.terminal.command-provider@1`, implemented by feature Plugins;
- `lenso.terminal.command@1`, consumed by terminal surfaces;
- `lenso.terminal.command`, which validates and routes one immutable catalog;
- `lenso.terminal.cli`, the generic CLI consumer Plugin identity; and
- `lenso-terminal-cli-surface`, which projects a validated catalog into Clap.

Products continue to own argv, stdout/stderr, exit codes, process lifecycle,
Host selection, and maintenance commands. Feature repositories continue to own
their command-provider Plugins and the domain Capabilities those commands use.

The first extraction intentionally excludes Agent-specific command providers,
Agent Host integration, and the TUI panel/suggestion contracts. Those packages
remain with Lenso Agent until another real product needs the same roles.

## Development

Run Cargo through the shared framework wrapper when it is available:

```sh
/Users/leosouthey/Projects/framework/.lenso-tools/bin/lenso-cargo fmt --all -- --check
./scripts/check-contracts.sh
/Users/leosouthey/Projects/framework/.lenso-tools/bin/lenso-cargo check --locked --workspace --all-targets
/Users/leosouthey/Projects/framework/.lenso-tools/bin/lenso-cargo test --locked --workspace --all-targets
/Users/leosouthey/Projects/framework/.lenso-tools/bin/lenso-cargo clippy --locked --workspace --all-targets -- -D warnings
./scripts/check-package-readiness.sh
```

Capability IDs, Plugin IDs, Descriptor versions, Schemas, generated Rust
projections, stream semantics, and `cross_lane_transfer = false` are preserved
from the accepted Lenso Agent implementation. Repository extraction alone is
not a compatibility event.

## First release order

Cargo verifies published dependency availability when preparing a package.
The initial release therefore publishes and verifies the two Capability crates
before preparing the aggregate Plugin and CLI packages:

1. `lenso-capability-terminal-command-provider`;
2. `lenso-capability-terminal-command`;
3. verify both registry versions;
4. rerun package readiness with
   `LENSO_TERMINAL_CAPABILITIES_PUBLISHED=1`; and
5. publish `lenso-terminal-command-plugin`, `lenso-terminal-cli-plugin`, then
   `lenso-terminal-cli-surface`.

No consumer switches ownership until all five packages or one immutable Git
revision from this repository are available without sibling path dependencies.
