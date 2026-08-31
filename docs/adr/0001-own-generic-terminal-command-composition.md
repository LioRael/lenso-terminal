# ADR 0001: Own generic terminal command composition

- Status: accepted
- Date: 2026-08-31
- Extracted from: `LioRael/lenso-agent` ADR 0090 at `cad5147`

## Context

Lenso Agent proved terminal command composition through two portable
Capabilities, one validated aggregate Plugin, and reusable CLI/TUI surfaces.
Lenso CLI is the second real consumer of the command contracts and CLI parser.
Keeping the generic packages inside the Agent repository would make a product
contract depend on one consumer's release and source layout.

## Decision

This repository owns the source and release of:

- `lenso-capability-terminal-command-provider`;
- `lenso-capability-terminal-command`;
- `lenso-terminal-command-plugin`;
- `lenso-terminal-cli-plugin`; and
- `lenso-terminal-cli-surface`.

The extraction preserves the Capability IDs, Descriptor versions, Schemas,
generated projections, Plugin IDs, root Slots, catalog validation, stream
semantics, and lane-transfer policy without compatibility aliases.

Agent-specific command providers, Agent Host generation leases, process
surfaces, and TUI panel/suggestion roles remain in Lenso Agent. A later TUI
extraction requires a second real consumer and its own deletion proof.

## Consequences

Lenso Agent and Lenso CLI consume one exact terminal release or revision. No
consumer uses a sibling path dependency or carries a copied contract. Removing
one feature command provider removes only its paths; removing the aggregate or
CLI consumer removes terminal composition while leaving feature behavior and
Host maintenance commands intact.
