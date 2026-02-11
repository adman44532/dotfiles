# Create a New NixOS Module

You are helping the user create a new NixOS module following the patterns in AGENTS.md.

## Information Gathering

Collect all required information in a single pass. Ask the user for:

1. **Module name** (kebab-case, e.g., `neovim`, `opencode`)
2. **Brief description** of what the module does
3. **Module type**:
   - `hardware` → `modules/hardware/` (no tags, explicit enable only)
   - `standard` → `modules/<category>/` (with tags for batch enabling)
4. **If standard, suggest category** based on description:
   | Category | Use For |
   |----------|---------|
   | `desktop` | Window managers, compositors, themes |
   | `development` | IDEs, editors, language tools |
   | `gaming` | Game launchers, performance tools |
   | `multimedia` | Media players, editors |
   | `social` | Chat apps, communication |
   | `terminal` | Shells, CLI tools |
   | `utilities` | Productivity, office, security |
   | `web` | Browsers, search engines |
5. **Implementation type**:
   - `package` - Just install system packages
   - `program` - Enable with options (programs.<name>.enable)
   - `home-manager` - User-level config via Home Manager
   - `flake` - External flake input with options
6. **If flake input**: Provide the flake URL and whether it follows nixpkgs
7. **Tags** (comma-separated, for standard modules only)

## Module Generation Plan

Present a plan with:

```
=== Module Creation Plan ===

📁 File: modules/<category>/<name>.nix
📋 Type: <hardware|standard>
🏷️  Tags: [<tags> or "none for hardware"]

Configuration options:
- programs.<name>.enable (if program/home-manager type)
- environment.systemPackages (always included)

<If flake input>
Flake: <URL>
Follows nixpkgs: <yes|no>
</If>

Next steps after creation:
1. Run `nix fmt` to format the new module
2. Check if module is imported in modules/<category>/default.nix
3. Add to machine's modules.nix:
   - enabledTags: ["<category>"] OR
   - enabledModules: ["<name>"]
```

## Execution (Build Mode)

When user switches to build mode:

1. **Create the module file** using the appropriate template from AGENTS.md:
   - Simple package: `mkModule "name" ["tag1" "tag2"] { environment.systemPackages = with pkgs; [package]; }`
   - Home Manager: `mkModule "name" ["tag1"] { home-manager.users.${user}.programs.name = { enable = true; }; }`
   - Hardware: `mkModule "name" [] { ... }` (NO tags)
   - Flake: Import from `${inputs.<name>.outPath}` or fetchTarball

2. **Run formatting**: `nix fmt`

3. **Validate syntax**: `nix flake check`

4. **Check default.nix**: Verify module is imported in `modules/<category>/default.nix`
   - If missing, add `./<name>.nix` to imports array

5. **Report completion** with:
   - File created location
   - Command to add to machine's modules.nix
   - Any manual steps required

## Examples

**Example 1 - Simple package:**
```
Module name: bat
Description: Cat clone with wings
Type: standard
Category: terminal (suggested)
Implementation: package
Tags: terminal
```
Creates: `modules/terminal/bat.nix`

**Example 2 - Home Manager program:**
```
Module name: fish
Description: Friendly interactive shell
Type: standard
Category: terminal
Implementation: home-manager
Tags: terminal
```
Creates: `modules/terminal/fish.nix` with shellAliases support

**Example 3 - Hardware module:**
```
Module name: amdgpu
Description: AMD GPU drivers and tools
Type: hardware
Implementation: package
```
Creates: `modules/hardware/amdgpu.nix` (no tags)

**Example 4 - Flake input:**
```
Module name: nh
Description: Nix helper tool
Type: standard
Category: utilities
Implementation: flake
Flake URL: github:nix-community/nh
Follows nixpkgs: yes
Tags: utilities
```
Creates: `modules/utilities/nh.nix` importing from flake
