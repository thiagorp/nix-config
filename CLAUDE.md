# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is Thiago's personal Nix configuration for managing macOS systems declaratively. It uses Nix flakes with nix-darwin for system configuration and home-manager for user environment management across two machines: personal and work computers.

## Architecture

### Core Structure
- **flake.nix**: Main entry point defining inputs (nixpkgs master, nix-darwin, home-manager), outputs, and system configurations. Uses `builtins.mapAttrs` to generate `darwinConfigurations` for each host.
- **darwin/**: System-level configuration modules
  - `configuration.nix`: Base darwin configuration imported by all machines. Imports home-manager and postgresql modules, applies overlays, configures system settings (keyboard remapping, trackpad, dock, finder).
  - `machines/`: Machine-specific configurations (personal.nix, work.nix).
  - `overlays/default.nix`: List of overlays applied via nixpkgs.overlays
  - `overlays/netcdf.nix`: Overlay that disables checks for the netcdf package
  - `postgresql.nix`: Configures PostgreSQL 16 with PostGIS, trust authentication for local connections, custom data directory
- **home/**: User environment configuration managed by home-manager
  - `thiago/default.nix`: Main user configuration that imports all submodules (direnv, git, nvim, ssh, vscode, zsh)
  - Configures allowUnfree, base packages (bat, fzf, jq, nixpkgs-fmt, ripgrep, tig, watchman)

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

### Environment Setup
The repository uses direnv with `.envrc` containing `use flake` to automatically load the development environment when entering the directory.

## PostgreSQL Configuration

PostgreSQL 16 with PostGIS is configured at the system level:
- Data directory: /usr/local/var/postgres
- Logs: /usr/local/var/log/postgres.{log,error.log}
- Authentication: Trust for all local connections (local, 127.0.0.1, ::1)
- Settings: UTC timezone, max 1000 connections, 1024 locks per transaction
- Runs as launchd user agent