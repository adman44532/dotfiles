# Contributing Guidelines

This document outlines the standards and conventions used in this NixOS dotfiles repository.

## Commit Format

Use **Conventional Commits**: `<type>(<scope>): <description>`

### Types

| Type | Purpose |
|------|---------|
| `feat` | New functionality (modules, features, configurations) |
| `fix` | Bug fixes and broken configurations |
| `chore` | Maintenance tasks (flake updates, formatting) |
| `refactor` | Code restructuring without behavior changes |
| `docs` | Documentation changes |

### Scopes

- **Machine**: `hephaestus`, `hermes`, `hades`
- **Module category**: `gaming`, `terminal`, `development`, `desktop`, `hardware`, etc.
- **Specific module**: `fish`, `neovim`, `steam`, `amdgpu`, etc.
- **System**: `flake`, `base`, `myLib`, `home-manager`

### Examples

```
feat(gaming): add MangoHud module for FPS overlay
fix(hephaestus): enable amdgpu driver for GPU support
chore(flake): update nixpkgs to unstable channel
refactor(fish): migrate to new shell alias syntax
docs(README): add git workflow section
```

### Breaking Changes

For breaking changes, add `BREAKING CHANGE:` in the footer:

```
refactor(lib): mkModule now requires explicit tags list

BREAKING CHANGE: All hardware modules must now explicitly set tags to [].
```

## Pre-Commit Checklist

Before creating any commit, run in order:

1. `nix fmt` - Format all nix files
2. `nix flake check` - Validate flake syntax and structure
3. `nh os dry build --flake .#<hostname>` - Dry run build for affected machines
4. Verify no build artifacts are staged (check for `result`, `result-*`)

## Module Guidelines

### Creating New Modules

Use `mkModule` from `myLib` (defined in `lib/default.nix`) for all new modules:

```nix
{myLib, pkgs, ...}: let
  inherit (myLib) mkModule;
in
mkModule "module-name" ["tag1" "tag2"] {
  # module configuration
}
```

### Module Organization

- **Hardware modules**: Place in `modules/hardware/` with NO tags
- **Standard modules**: Place in appropriate category subdirectory with relevant tags
- **Categories**: `desktop`, `development`, `gaming`, `hardware`, `multimedia`, `social`, `terminal`, `utilities`, `web`

### Tag System

Tags enable batch module activation:
- `"desktop"` - Desktop environment components
- `"terminal"` - Terminal tools and shell
- `"development"` - Development tools
- `"gaming"` - Gaming-related modules

Configure tags in `machines/<hostname>/modules.nix`:

```nix
{
  enabledModules = ["specific-module"];
  enabledTags = ["desktop" "terminal"];
  disabledModules = [];
}
```

## Code Style

### Formatting
- Run `nix fmt` before completing any nix modifications
- alejandra is the formatter (strict and idempotent)

### Naming Conventions
- Module filenames/ids: kebab-case (`fish`, `neovim`, `amdgpu`)
- Attribute sets: camelCase (`programs.fish.shellAliases`)
- Machine names: lowercase (`hephaestus`, `hermes`, `hades`)

### Conditional Logic
- Use `lib.mkIf` for optional configuration blocks
- Use `let` bindings for computed values and readability
- Use `${hostname}` for machine-specific conditionals

## Git Workflow

### Safety Rules

- **Never execute system-modifying commands** without explicit permission:
  - `nh os switch`, `nixos-rebuild switch`
  - `nix flake update`
- Agents MAY create commits for their changes
- Agents MUST announce when creating commits
- Agents MUST NEVER push to remote

### Diagnostics Allowed

- `nh os dry build`, `nix flake check`, `nix build`
- File exploration and reading
