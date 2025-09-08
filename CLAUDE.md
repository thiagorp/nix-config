# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is Thiago's personal Nix configuration for managing macOS systems declaratively. It uses Nix flakes with nix-darwin for system configuration and home-manager for user environment management across two machines: personal and work computers.

## Architecture

### Core Structure
- **flake.nix**: Main entry point defining inputs, outputs, and system configurations
- **darwin/**: System-level configuration modules
  - `configuration.nix`: Base darwin configuration shared across machines
  - `machines/`: Machine-specific configurations (personal.nix, work.nix)  
  - `overlays/`: Package overlays including custom claude-code derivation
  - `postgresql.nix`: Database service configuration
- **home/**: User environment configuration managed by home-manager
  - `thiago/default.nix`: Main user configuration importing all modules
  - Individual modules: `git.nix`, `nvim.nix`, `zsh.nix`, `ssh.nix`, `direnv.nix`
  - `vscode/`: VS Code configuration
- **packages/**: Custom Nix package definitions
  - `claude-code/default.nix`: Custom Claude Code CLI package with multiple binary variants

### Key Components
- **Inputs**: nixpkgs (master), nix-darwin, home-manager
- **Target Architecture**: aarch64-darwin (Apple Silicon Macs)
- **Supported Hosts**: "Cacos-Personal-Computer", "Thiagos-Work-Computer"
- **Development Shell**: Includes alejandra (Nix formatter) and nfu (flake update script)

## Common Commands

### Nix Flake Management
```bash
# Update flake inputs
nix flake update
# or use the custom script
nfu

# Build system configuration
darwin-rebuild switch --flake .

# Build for specific host
darwin-rebuild switch --flake .#Cacos-Personal-Computer
darwin-rebuild switch --flake .#Thiagos-Work-Computer

# Enter development shell
nix develop
```

### Code Formatting
```bash
# Format Nix code (available in dev shell)
alejandra .
```

### Package Development
```bash
# Build custom packages
nix build .#packages.aarch64-darwin.claude-code

# Test package installation
nix shell .#packages.aarch64-darwin.claude-code
```

### Environment Setup
The repository uses direnv with `.envrc` containing `use flake` to automatically load the development environment when entering the directory.

## Custom Claude Code Package

The configuration includes a custom derivation for Claude Code CLI that provides three binary variants:
- `claude`: Default with `--dangerously-skip-permissions` (YOLO mode)  
- `safe-claude`: With permission prompts
- `yolo-claude`: Explicit YOLO mode with skipped permissions

This package is automatically installed on the personal machine configuration.