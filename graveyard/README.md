# Graveyard

This directory contains archived configurations for applications that are not currently active in the main system configuration but may be needed for reference or quick re-enablement.

## Purpose

The graveyard serves as a parking lot for:
- **Temporarily disabled** applications that might return
- **Experimental** configurations that aren't ready for production
- **Reference** configurations for apps you might want to enable on specific machines

## Usage

To enable a graveyard configuration on a specific machine:

1. Copy the relevant file from `graveyard/` to the appropriate location in `modules/`
2. Add the module to your machine's `modules.nix`:
   ```nix
   {
     enabledModules = ["your-module-name"];
     # ...
   }
   ```
3. Run `nix fmt` and test with `nh os dry build --flake .#<hostname>`

## Current Contents

- `vscode.nix` - VSCode configuration (previously used, available for machines that need it)

## Note

Files in this directory are **not** automatically imported into the system. They are purely for manual reference and copying.
