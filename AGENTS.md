# AGENTS.md - NixOS Dotfiles

This file provides guidelines for agentic coding agents operating in this NixOS flake repository.

## Build/Lint/Test Commands

| Command | Purpose |
|---------|---------|
| `nix fmt` | Format all nix files (uses alejandra, the strict formatter) |
| `nix flake check` | Validate flake syntax and structure |
| `nh os dry build --flake .#<hostname>` | Dry run build to check for errors |
| `nix build .#nixosConfigurations.<hostname>.system` | Build system without switching |
| `nix flake update` | Update flake inputs (requires approval) |
| `nh os switch --flake .#<hostname>` | Apply configuration (requires approval - NEVER execute) |

**Note**: Always prefer `dry build` for diagnostics. Never switch generations or update flakes without explicit permission.

## Git Commit Guidelines

### Commit Format

Use Conventional Commits: `<type>(<scope>): <description>`

**Types**: feat, fix, chore, refactor, docs

**Scopes**: Machine names (hephaestus, hermes, hades), module categories (gaming, terminal, development, etc.), specific modules (fish, neovim, steam, etc.), or system-level (flake, base, myLib, home-manager)

### Pre-Commit Checklist

Before creating any commit, run in order:

1. `nix fmt` - Format all nix files
2. `nix flake check` - Validate flake syntax and structure
3. `nh os dry build --flake .#<hostname>` - Dry run build for affected machines
4. Verify no build artifacts are staged (check for `result`, `result-*`)

### Example

```
refactor(myLib): mkModule now requires explicit tags list

- Updated mkModule signature validation

BREAKING CHANGE: All hardware modules must now explicitly set tags to [].
```

## Code Style Guidelines

### Formatting
- Run `nix fmt` before completing any nix modifications
- alejandra is strict and idempotent - format will not change once applied

### Module Pattern
Use `mkModule` from `myLib` (defined in `lib/default.nix`) for all new modules:
```nix
mkModule "module-name" ["tag1" "tag2"] {
  # module configuration
}
```

### Hardware Modules
- Location: `modules/hardware/`
- NO tags - explicitly enabled via `enabledModules` in machine config
- Examples: `amdgpu.nix`, `nvidia_prime.nix`, `audio.nix`, `bluetooth.nix`

### Standard Modules
- Location: Category subdirectory under `modules/`
- Tags required for batch enabling via `enabledTags`
- Categories: `desktop`, `development`, `gaming`, `hardware`, `multimedia`, `social`, `terminal`, `utilities`, `web`

### Naming Conventions
- Module filenames/ids: kebab-case (`fish`, `neovim`, `amdgpu`)
- Attribute sets: camelCase (`programs.fish.shellAliases`)
- Machine names: lowercase (`hephaestus`, `hermes`, `hades`)

### Conditional Logic
- Use `lib.mkIf` for optional configuration blocks
- Use `let` bindings for computed values and readability
- Use `${hostname}` for machine-specific conditionals

### Imports
- Local modules: relative paths (`./default.nix`, `./fish.nix`)
- External flake inputs: use `${inputs.<name>.outPath}` or fetchTarball
- Example: `${inputs.stylix.nixosModules.stylix}`

### External Inputs Pattern
- Pass `inputs` globally via `specialArgs` in flake.nix (already configured)
- In modules, use `let inherit (inputs) <name>` to extract specific inputs
- This keeps flake.nix clean and makes dependencies explicit per-module
- Example:
  ```nix
  {myLib, pkgs, inputs, ...}: let
    inherit (myLib) mkModule;
    inherit (inputs) vicinae;
  in
    mkModule "example" ["tag"] {
      # use vicinae here
    }
  ```

## Repository Structure

```
/home/adman/dotfiles/
├── flake.nix              # Entry point, machine definitions, formatter
├── lib/default.nix        # Helper functions (mkModule, isEnabled, ternary)
├── modules/               # Categorized modules
│   ├── base.nix           # Base system configuration
│   ├── desktop/           # Hyprland, Waybar, Rofi, themes
│   ├── development/       # VSCode, Zed, Neovim, LaTeX
│   ├── gaming/            # Steam, Heroic, MangoHud, Gamemode
│   ├── hardware/          # GPU, audio, Bluetooth drivers (no tags)
│   ├── multimedia/        # Spotify, VLC, image editors
│   ├── social/            # Vesktop, communication apps
│   ├── terminal/          # Fish, Git, ripgrep, lazygit, etc.
│   ├── utilities/         # Bitwarden, LibreOffice, Obsidian
│   └── web/               # Browsers, SearXNG
└── machines/<hostname>/   # Per-machine configurations
    ├── configuration.nix  # Machine-specific imports and settings
    ├── hardware-configuration.nix
    ├── disko.nix          # Disk partitioning
    ├── modules.nix         # Module activation (enabledModules, enabledTags)
    └── home.nix           # Home Manager user config
```

## Machine Configuration

### Adding a New Machine
1. Create directory: `machines/<hostname>/`
2. Create required files: `configuration.nix`, `hardware-configuration.nix`, `disko.nix`, `modules.nix`, `home.nix`
3. Add to `flake.nix` lines 85-102 following existing pattern

### Variable Usage
- `${user}` - Username (defined in flake.nix per machine, use for user paths)
- `${hostname}` - Machine name (use for hardware-specific conditionals)
- `${inputs}` - Flake inputs (passed to all modules)

### Machine Config Example (modules.nix)
```nix
{
  enabledModules = ["amdgpu" "audio" "bluetooth" "zswap"];
  enabledTags = ["desktop" "terminal" "development"];
  disabledModules = [];
}
```

## Module Creation Workflow

1. For new modules, ask user for: name, location (or suggest), tags (if not hardware)
2. If file already exists and user specifies it, modify directly
3. Hardware modules: place in `modules/hardware/`, no tags
4. Standard modules: place in appropriate category with relevant tags

### Module Pattern Examples

**Simple package module** (`modules/terminal/bat.nix`):
```nix
{myLib, pkgs, ...}: let inherit (myLib) mkModule; in
mkModule "bat" ["terminal"] {
  environment.systemPackages = with pkgs; [bat];
}
```

**Home Manager integration** (`modules/terminal/fish.nix`):
```nix
{myLib, user, ...}: let inherit (myLib) mkModule; in
mkModule "fish" ["terminal"] {
  home-manager.users.${user}.programs.fish = {
    enable = true;
    shellAliases = { ll = "ls -l"; };
  };
}
```

**Hardware module** (`modules/hardware/amdgpu.nix`):
```nix
{myLib, pkgs, ...}: let inherit (myLib) mkModule; in
mkModule "amdgpu" [] {  # NO tags
  environment.systemPackages = with pkgs; [vulkan-tools lact];
}
```

## Critical Rules

1. **Never execute system-modifying commands** without explicit permission:
   - `nh os switch`, `nixos-rebuild switch`
   - `nix flake update`
   - System state changes

2. **Git operations**:
   - Agents MAY create commits for their changes
   - Agents MUST announce when creating commits with: "Created commit: <commit message excerpt>"
   - Agents MUST NEVER push to remote
   - Rationale: Local commits can be amended/reviewed, pushed commits cannot

3. **Diagnostics allowed**: `nh os dry build`, `nix flake check`, `nix build`, file exploration

4. **Flake updates**: Always ask for approval before running `nix flake update`

5. **Module placement**: Ask user for location unless file already exists

## Common Patterns and Pitfalls

- **Fish aliases**: Cannot alias reserved keywords like `test`
- **GPU drivers**: Never enable both `amdgpu` and `nvidia_prime`
- **Stylix**: Some modules depend on `config.stylix` (imported in base.nix)
- **Hardcoded paths**: Some paths required at evaluation time (e.g., programs.nh.flake)

## Useful References

- Module system: `myLib` (defined in `lib/default.nix`)
- Module examples: `modules/terminal/` (simple patterns)
- Machine configs: `machines/hephaestus/modules.nix`
- Flake entry: `flake.nix` lines 83-102 (formatter, machines)
