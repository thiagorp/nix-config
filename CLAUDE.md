# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is Thiago's personal Nix configuration for managing macOS systems declaratively. It uses Nix flakes with nix-darwin for system configuration and home-manager for user environment management across two machines: personal and work computers.

## Architecture

### Core Structure
- **flake.nix**: Main entry point defining inputs (nixpkgs master, nix-darwin, home-manager), outputs, and system configurations. Uses `builtins.mapAttrs` to generate `darwinConfigurations` for each host.
- **darwin/**: System-level configuration modules
  - `configuration.nix`: Base darwin configuration imported by all machines. Imports home-manager and postgresql modules, applies overlays, configures system settings (keyboard remapping, trackpad, dock, finder).
  - `machines/`: Machine-specific configurations (personal.nix, work.nix). Personal machine includes claude-code in systemPackages.
  - `overlays/default.nix`: List of overlays applied via nixpkgs.overlays
  - `overlays/claude-code.nix`: Overlay that adds custom claude-code package from ../../packages/claude-code
  - `postgresql.nix`: Configures PostgreSQL 16 with PostGIS, trust authentication for local connections, custom data directory
- **home/**: User environment configuration managed by home-manager
  - `thiago/default.nix`: Main user configuration that imports all submodules (direnv, git, nvim, ssh, vscode, zsh)
  - Configures allowUnfree, base packages (bat, fzf, jq, nixpkgs-fmt, tig, watchman)
- **packages/**: Custom Nix package definitions
  - `claude-code/default.nix`: Fetches from npm registry, creates three wrappers: `claude` (safe), `safe-claude` (safe), `yolo-claude` (--dangerously-skip-permissions)

### Key Components
- **Inputs**: nixpkgs (master), nix-darwin, home-manager
- **Target Architecture**: aarch64-darwin (Apple Silicon Macs)
- **Supported Hosts**: "Cacos-Personal-Computer", "Thiagos-Work-Computer"
- **Development Shell**: Includes alejandra (Nix formatter), nfu (flake update script), nodejs_22

## Common Commands

### Nix Flake Management
```bash
# Update flake inputs
nix flake update
# or use the custom script (available in dev shell)
nfu

# Apply configuration changes (rebuilds and switches)
# IMPORTANT: Use sudo with darwin-rebuild switch
sudo darwin-rebuild switch --flake .

# Build for specific host
sudo darwin-rebuild switch --flake .#Cacos-Personal-Computer
sudo darwin-rebuild switch --flake .#Thiagos-Work-Computer

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

# Update Claude Code package version
# 1. Update version and hash in packages/claude-code/default.nix
# 2. Get new hash by running build with wrong hash, copying error output
# Or use: nix-prefetch-url https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-VERSION.tgz
```

### Environment Setup
The repository uses direnv with `.envrc` containing `use flake` to automatically load the development environment when entering the directory.

## Custom Claude Code Package

The configuration includes a custom derivation for Claude Code CLI (packages/claude-code/default.nix) that fetches from npm registry and creates three binary variants:
- `claude`: Default with permission prompts (safe mode)
- `safe-claude`: With permission prompts (same as default)
- `yolo-claude`: Explicit YOLO mode with `--dangerously-skip-permissions`

The package is:
1. Defined in packages/claude-code/default.nix
2. Exposed via overlay in darwin/overlays/claude-code.nix
3. Automatically installed only on the personal machine (darwin/machines/personal.nix)

## PostgreSQL Configuration

PostgreSQL 16 with PostGIS is configured at the system level:
- Data directory: /usr/local/var/postgres
- Logs: /usr/local/var/log/postgres.{log,error.log}
- Authentication: Trust for all local connections (local, 127.0.0.1, ::1)
- Settings: UTC timezone, max 1000 connections, 1024 locks per transaction
- Runs as launchd user agent