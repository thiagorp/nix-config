# AGENTS.md

## Build/Test Commands
- **Build system**: Ask user to run `darwin-rebuild switch --flake .` (requires sudo)
- **Build for specific host**: Ask user to run `darwin-rebuild switch --flake .#Cacos-Personal-Computer` or `darwin-rebuild switch --flake .#Thiagos-Work-Computer`
- **Format code**: `alejandra .` (or `alejandra <file.nix>` for single file)
- **Update flake**: `nix flake update` or `nfu`
- **Test package build**: `nix build .#packages.aarch64-darwin.claude-code`
- **Enter dev shell**: `nix develop`

## Code Style
- **Formatting**: Use `alejandra` (Nix formatter) - always format before committing
- **Imports**: Group imports at top; follow pattern `{config, pkgs, ...}:` for function parameters
- **Attribute sets**: Use `with pkgs;` for package lists to reduce repetition
- **Naming**: Use kebab-case for file names (e.g., `claude-code.nix`), camelCase for Nix attributes
- **Structure**: Keep machine-specific config in `darwin/machines/`, user config in `home/thiago/`, overlays in `darwin/overlays/`
- **Comments**: Minimal inline comments; use # for single-line comments
- **Types**: Leverage Nix's type system; use `lib` functions for validation when needed
- **Strings**: Use double quotes for strings; use `''` for multi-line strings
- **Functions**: Pattern match on attribute sets in function parameters
- **Error handling**: Use `lib.assertMsg` for validation; prefer explicit error messages
