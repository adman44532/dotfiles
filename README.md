# The Supersuit

This is the repo where I configure my funny machines that are always breaking.

Established: 26th May 2023
NixOS-ified: 6th Nov 2024

## Project Overview

This repository contains my NixOS dotfiles configured using flakes with a modular system. The architecture consists of:

- **Flake configuration** (`flake.nix`) - Entry point that defines machines and manages flake inputs
- **Module system** (`modules/`) - Reusable configuration modules organized by category
- **Machine configs** (`machines/`) - Machine-specific configurations (configuration, hardware, disko, networking, home)
- **Library** (`lib/`) - Helper functions for the module system (accessible via `myLib` in modules)

## Module System

### How `mkModule` Works

The `mkModule` function is provided via `myLib` in modules (defined in `lib/default.nix`):

```nix
mkModule = name: tags: body
```

Modules are enabled when:
1. The module name is in `enabledModules`, OR
2. Any of its tags are in `enabledTags`
3. The module is NOT in `disabledModules`

### Module Organization

Modules are organized by category in `modules/`:

- `desktop/` - Desktop environment (Hyprland, Waybar, Rofi, theme)
- `development/` - Development tools (VSCode, Zed, Neovim, LaTeX)
- `gaming/` - Gaming (Steam, Heroic, MangoHud, Gamemode)
- `hardware/` - Hardware drivers and config (GPU, audio, Bluetooth, swap)
- `multimedia/` - Media applications (Spotify, VLC, image editors)
- `social/` - Communication apps (Vesktop)
- `terminal/` - Terminal tools (Fish shell, Git, ripgrep, etc.)
- `utilities/` - General utilities (Bitwarden, LibreOffice, Obsidian)
- `web/` - Browsers and web services (Brave, Zen, SearXNG)

Each category has a `default.nix` that imports its modules.

### Tag System

Tags provide a way to enable groups of modules. Examples:
- `"desktop"` - Desktop environment components
- `"terminal"` - Terminal tools and shell
- `"development"` - Development tools
- `"gaming"` - Gaming-related modules
- `"hardware"` - Hardware drivers

Tags are configured in `machines/<hostname>/modules.nix`:

```nix
{
  enabledModules = ["specific-module"];
  enabledTags = ["desktop" "terminal"];
  disabledModules = [];
}
```

## Adding Modules

### Simple Package Module Pattern

For modules that just install packages:

```nix
{myLib, pkgs, ...}: let
  inherit (myLib) mkModule;
in
mkModule "module-name" ["category"] {
  # module configuration
}
```

Examples: `bat.nix`, `bottles.nix`, `brave.nix`, `libreoffice.nix`, `obsidian.nix`

### Module with Home Manager Integration

```nix
{myLib, pkgs, user, ...}: let
  inherit (myLib) mkModule;
in
mkModule "module-name" ["category"] {
  home-manager.users.${user}.programs.some-program = {
    enable = true;
    settings = {
      # program-specific config
    };
  };
}
```

Examples: `bat.nix`, `nvim.nix`, `fish.nix`

### Module with Service Configuration

```nix
{util, pkgs, ...}: let
  inherit (util) mkModule;
in
mkModule "module-name" ["category"] {
  services.some-service = {
    enable = true;
    settings = {};
  };
  environment.systemPackages = with pkgs; [some-package];
}
```

Examples: `bluetooth.nix`, `clipboard.nix`, `mullvad.nix`

### Module with Conditional Logic

```nix
{myLib, pkgs, hostname, ...}: let
  inherit (myLib) mkModule;

  machineConfig = {
    hostname1 = {setting1 = "value1";};
    hostname2 = {setting1 = "value2";};
  };

  config = machineConfig.${hostname} or null;
in
mkModule "module-name" ["category"] {
  boot.kernelParams =
    if config != null
    then ["param=${config.setting1}"]
    else [];
}
```

Examples: `zswap.nix`, `nvidia_prime.nix`

### Module with Shell Script Integration

```nix
{myLib, pkgs, ...}: let
  inherit (myLib) mkModule;

  customScript = pkgs.writeShellScriptBin "script-name" ''
    #!/usr/bin/env bash
    # Your shell script here
  '';
in
mkModule "module-name" ["category"] {
  environment.systemPackages = with pkgs; [
    customScript
    other-packages
  ];
}
```

Examples: `screenshots.nix`

## Machine Configuration

### Adding a New Machine

1. Create machine directory in `machines/<hostname>/`
2. Create these files:
   - `configuration.nix` - Machine-specific system configuration
   - `hardware-configuration.nix` - Hardware detection (generated with `nixos-generate-config`)
   - `disko.nix` - Disk partitioning configuration
   - `modules.nix` - Module activation configuration
   - `home.nix` - Home Manager configuration
   - `networking.nix` (optional) - Network/firewall configuration

3. Add machine to `flake.nix`:

```nix
my-machine = mkSystem {
  hostname = "my-machine";
  user = "username";  # Define user here - this is the primary user for this machine
  extraModules = [];
};
```

### User vs Hostname

- **User (`${user}`)**: Defined once in `flake.nix` per machine. Used throughout the config for:
  - Home-manager user paths
  - User-specific package configurations
  - User groups and permissions

- **Hostname (`${hostname}`)**: Used for:
  - Machine-specific conditional logic (e.g., different swap settings per machine)
  - Network configuration
  - Hardware-specific settings

**Best Practice**: Focus on hostname for machine-specific configuration, not username. Use `${user}` for anything user-path related.

### Machine Config Files

**configuration.nix** - Imports and basic settings:
```nix
{
  pkgs, user, inputs, ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_zen;
  users.users.${user} = {isNormalUser = true; extraGroups = [...]};
}
```

**modules.nix** - Module activation:
```nix
{
  enabledModules = ["zram"];
  enabledTags = ["desktop" "terminal"];
  disabledModules = [];
}
```

## Hardware Configuration

All hardware modules must be manually added to the `modules.nix` via `enabledModules` as each machine is different. A tag isn't avaiable.

### GPU Drivers

Choose ONE per machine:

- `amdgpu` - AMD GPU driver with vulkan-tools and lact
- `nvidia_prime` - Nvidia driver with hybrid graphics support

**Example**: In `machines/<hostname>/modules.nix`:
```nix
{
  enabledModules = ["amdgpu"];  # OR "nvidia_prime"
  enabledTags = [];
}
```

### Swap Configuration

Two different swap compression approaches:

- **zram** - Swap to compressed RAM block devices (for memory-constrained systems like Hermes)
- **zswap** - Compressed swap cache before disk (configured per machine with different pool sizes)

## NixOS Learnings & Workflows

### Why `${user}` Variable

The `${user}` variable (defined in flake.nix) is used throughout the config for user paths. This makes it easy to change usernames by updating one location. The variable is passed through specialArgs to modules.

### When to Use Hostname

Use `${hostname}` for machine-specific configuration that depends on the actual hardware or network setup of that machine. Examples:
- Different swap settings per machine (see `zswap.nix`)
- Network/firewall rules
- Desktop Environment Settings

### Common Patterns

**Shell Aliases in Fish**:
- Aliases are defined in modules like `bat.nix`, `uutils.nix`
- Be careful with Fish reserved keywords (e.g., `test` cannot be aliased)

**Home Manager Integration**:
- Use `home-manager.users.${user}` for user-specific configurations
- Examples: shell aliases, program settings, fonts

**Conditional Logic**:
- Use `mkIf` from lib for conditional configuration
- Pattern: `config = mkIf condition body` (handled automatically by `mkModule`)

### Pitfalls & Solutions

**Reserved Keywords in Fish**:
- Cannot alias `test` in Fish - it's a reserved keyword
- Use the builtin `test` command directly

**GPU Driver Conflicts**:
- Never enable both amdgpu and nvidia_prime
- Manually select one in machine's modules.nix

**Hardcoded Paths**:
- Some paths must be hardcoded because they're needed at evaluation time (e.g., `programs.nh.flake` in base.nix)

**Module Dependencies**:
- Some modules reference `config.stylix` - ensure stylix is imported (done in base.nix)
- Check imports order if a module depends on another

## Git Workflow & Commit Style

See [CONTRIBUTING.md](./CONTRIBUTING.md) for detailed commit conventions and guidelines.

## The USB Commands

A few times new I have needed to USB boot and fix the config from the outside.

>[!NOTE]
> `boot-configuration.nix` should be a drop in replacement and updated regularly to work on fresh machines.

1. **Enable flakes in NixOS configuration**
   Add the following line to your `configuration.nix` then `sudo nixos-rebuild switch` to enable it:
   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```

2. **Check available drives**
   Run:
   `lsblk`
   This will list all drives connected to the system.

3. **Identify each drive**
   - Mount each drive if needed and inspect its contents to confirm its purpose.

4. **Mount the root partition**
   Replace `sdXn` with your identified root partition:
   `mount /dev/sdXn /mnt`

5. **Generate a new configuration**
   If using `disko`, add the `--no-filesystems` flag:
   `nixos-generate-config --no-filesystems --root /mnt`

6. **Verify drive names**
   Ensure the drive names in `lsblk` match those in `disko-config.nix`.

7. **Create a new boot generation**
   Run:
   `sudo nixos-rebuild boot --flake .#<name>`

8. **Reboot**
   Restart into the new configuration.
