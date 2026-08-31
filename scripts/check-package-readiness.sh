#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cargo_command="${LENSO_CARGO:-cargo}"
cd "${repo_root}"

capability_packages=(
  lenso-capability-terminal-command-provider
  lenso-capability-terminal-command
)
dependent_packages=(
  lenso-terminal-command-plugin
  lenso-terminal-cli-plugin
  lenso-terminal-cli-surface
)

for package in "${capability_packages[@]}"; do
  "${cargo_command}" package --locked --allow-dirty -p "${package}"
done

for package in "${dependent_packages[@]}"; do
  "${cargo_command}" package --locked --allow-dirty --no-verify --list -p "${package}" >/dev/null
done

if [[ "${LENSO_TERMINAL_CAPABILITIES_PUBLISHED:-0}" == "1" ]]; then
  for package in "${dependent_packages[@]}"; do
    "${cargo_command}" package --locked --allow-dirty -p "${package}"
  done
else
  printf '%s\n' \
    'dependent package payloads checked; full verification waits for both Capability 0.1.0 packages to be published' \
    'rerun with LENSO_TERMINAL_CAPABILITIES_PUBLISHED=1 after registry verification'
fi
