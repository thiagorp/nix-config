# Repository Guidelines

## Project Structure & Module Organization
The flake centers on `flake.nix` and `flake.lock`, with system-specific configuration under `darwin/`. Keep shared Darwin defaults in `darwin/configuration.nix`, and host overrides in `darwin/machines/` (e.g. `darwin/machines/Thiagos-Work-Computer.nix`). User-facing Home Manager modules live in `home/thiago/`, while reusable package definitions sit in `packages/` (such as `packages/claude-code/default.nix`). Store overlays inside `darwin/overlays/` and keep helper scripts in `bin/`. When adding new modules, mirror this layout so future changes are easy to discover.

## Build, Test, and Development Commands
- `darwin-rebuild switch --flake .` — Apply the current configuration to the active host (requires `sudo`).
- `darwin-rebuild switch --flake .#Cacos-Personal-Computer` or `.#Thiagos-Work-Computer` — Target a specific machine configuration.
- `nix develop` — Enter the repo’s development shell with pinned tooling.
- `nix flake check` — Evaluate the flake to verify modules build cleanly.
- `nix build .#packages.aarch64-darwin.claude-code` — Build and validate the custom package.
- `alejandra .` — Format all Nix sources; prefer `alejandra path/to/file.nix` for focused edits.

## Coding Style & Naming Conventions
Write Nix functions as `{config, pkgs, ...}: { ... }`, grouping imports at the top of each file. Prefer kebab-case filenames (`darwin/overlays/tooling.nix`) and camelCase attribute names (`packageOverrides`). Use `with pkgs;` inside package lists to avoid repetition, double quotes for strings, and `''` for multi-line text. Keep comments sparse and informative (`# Pin Postgres to LTS`). Always run `alejandra` before committing to maintain consistent formatting.

## Testing Guidelines
Treat `nix flake check` as the minimum gate before review; extend it with host-specific builds when you touch system modules (`darwin-rebuild --list-generations` helps confirm history). For package work, run `nix build` against the affected attributes and smoke-test results inside `nix develop`. Document any manual verification steps in the pull request so reviewers can reproduce them quickly.

## Commit & Pull Request Guidelines
Follow the existing concise, imperative commit style (`Upgrade Claude`, `Add rg`). Group related changes per commit and avoid mixing formatting-only edits with functional updates. Pull requests should include a short summary, linked issues when applicable, and notes on testing commands executed. Add screenshots or configuration snippets if a change alters visible behaviour or system services. Confirm CI or manual checks in the PR description to speed up review.
